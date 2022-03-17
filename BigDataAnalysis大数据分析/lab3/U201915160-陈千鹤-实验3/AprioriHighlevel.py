#!/usr/bin/env python
# -*- coding:utf-8 -*-
# project: lab
# author: Chen Qianhe
# GitHub: https://github.com/chenqianhe
# datetime: 2021/12/20 23:12
import copy
import pandas as pd
import itertools

min_support = 0.005
min_confidence = 0.5
nBuckets = 1000


def combine(l, n):
    # 待选n阶频繁项列表
    if n == 2:
        return list(itertools.combinations(l, n))
    if n > 2:
        tmp = []
        for i in range(len(l) - 1):
            for j in range(i + 1, len(l)):
                s = set(l[i]) & set(l[j])
                if s and len(list(s)) == n - 2:
                    tmp.append(tuple(sorted(set(l[i]) | set(l[j]))))

        return list(set(tmp))


def reduceFreq(groups_n, n, data, data_num, min_support):
    # n阶频繁项及支持度
    support_n = {g: 0 for g in groups_n}

    if n == 1:
        for i in range(data_num):
            for j in range(len(data[i])):
                k = data[i][j]
                support_n[k] = support_n[k] + 1.0 / data_num
    else:
        for i in range(data_num):
            for g in groups_n:
                if set(g).issubset(set(data[i])):
                    support_n[g] = support_n[g] + 1.0 / data_num

    # 舍弃低于支持度的频繁项集
    for i in list(support_n.keys()):
        if support_n[i] < min_support:
            del support_n[i]

    return support_n


def hash(x, y, nBuckets):
    return int(str(x) + str(y)) % nBuckets



def PCY(nSub1Freq, n, data, data_num, min_support, nBuckets):
    # 计算2阶频繁项及支持度
    cnt = [0] * nBuckets
    bitmap = [0] * nBuckets
    pairs = []
    pairs2hash = {}

    # Pass 1
    for i in range(data_num):
        for j in range(len(data[i]) - 1):
            for k in range(j + 1, len(data[i])):
                g = tuple([data[i][j], data[i][k]])
                f = hash(g[0], g[1], nBuckets)
                cnt[f] += 1
                if g[0] in nSub1Freq and g[1] in nSub1Freq and g not in pairs:
                    pairs.append(g)
                    pairs2hash[g] = f

    pairs = sorted(pairs)

    # Pass 2
    min_cnt = min_support * data_num
    bitmap = [1 if cnt[i] >= min_cnt else 0 for i in range(nBuckets)]
    print(bitmap)

    candidateFreq = []
    for i in range(len(pairs)):
        g = pairs[i]
        if bitmap[pairs2hash[g]] == 1:
            candidateFreq.append(pairs[i])

    support_2 = {}
    candidateFreq_num = len(candidateFreq)
    for i in range(candidateFreq_num):
        support = 0
        for j in range(data_num):
            if set(candidateFreq[i]).issubset(set(data[j])):
                support += 1.0 / data_num
        if support >= min_support:
            support_2[candidateFreq[i]] = support

    return support_2


# 关联规则
def generateRules(support, min_confidence):
    rules = {}
    keys = list(support.keys())
    for k in keys:
        if type(k) != int:
            rules = {**rules, **appendRule([set(k), set()], support, min_confidence)}

    return rules


def appendRule(k, support, min_confidence):
    # 生成全部高于置信度的关联规则
    if len(k[0]) == 1:
        return {}
    rules = {}
    union = tuple(sorted(k[0] | k[1]))
    if union not in support.keys():
        return {}
    for i in k[0]:
        tmp = copy.deepcopy(k)
        tmp[0].remove(i)
        tmp[1].add(i)
        tmp[0], tmp[1] = tuple(sorted(tmp[0])), tuple(sorted(tmp[1]))

        # 将单元素元组转化为int作为键
        tmp[0] = tmp[0][0] if len(tmp[0]) == 1 else tmp[0]
        tmp[1] = tmp[1][0] if len(tmp[1]) == 1 else tmp[1]

        if tmp[0] not in support.keys():
            continue

        confidence = support[union] / support[tmp[0]]
        if confidence >= min_confidence - 1e-6:
            rules[(tmp[0], tmp[1])] = confidence
            tmp[0] = tuple([tmp[0]]) if type(tmp[0]) == int else tmp[0]
            tmp[1] = tuple([tmp[1]]) if type(tmp[1]) == int else tmp[1]

            rules = {**rules, **appendRule([set(tmp[0]), set(tmp[1])], support, min_confidence)}

    return rules


if __name__ == '__main__':
    data = pd.read_csv("./实验三/数据/Groceries.csv")['items']
    data = [d.lstrip('{').rstrip('}').split(',') for d in data]
    data_num = len(data)

    items = list(set(list(itertools.chain(*data))))
    item_num = len(items)

    id2item = {}
    for id, item in enumerate(items):
        id2item[id] = item
    item2id = {v: k for k, v in id2item.items()}

    for i in range(data_num):
        for j in range(len(data[i])):
            data[i][j] = item2id[data[i][j]]
        data[i].sort()

    # 求一阶频繁项集
    groups_1 = [i for i in range(item_num)]
    support_1 = reduceFreq(groups_1, 1, data, data_num, min_support)

    # 求二阶频繁项集
    groups_2 = combine(list(support_1.keys()), 2)
    support_2 = PCY(list(support_1.keys()), 2, data, data_num, min_support, nBuckets)

    # 求三阶频繁项集
    groups_3 = combine(list(support_2.keys()), 3)
    support_3 = reduceFreq(groups_3, 3, data, data_num, min_support)

    # 求四阶频繁项集
    groups_4 = combine(list(support_3.keys()), 4)
    support_4 = reduceFreq(groups_4, 4, data, data_num, min_support)
    print('support_1: %d   support_2: %d   support_3: %d   support_4: %d' %
          (len(support_1), len(support_2), len(support_3), len(support_4)))
    print('support: %d' % (len(support_1) + len(support_2) + len(support_3) + len(support_4)))

    # 求关联规则
    support = {**support_1, **support_2, **support_3, **support_4}
    rules = generateRules(support, min_confidence)
    print('rules: %d' % (len(rules)))

    # 输出结果文件
    with open('output.txt', 'w') as f:
        # 1阶
        f.write('一阶: %d\n' % len(support_1))
        for k, v in support_1.items():
            k = id2item[k]
            f.write(k + ' : ' + str(v) + '\n')
        # 2阶
        f.write('\n二阶: %d\n' % len(support_2))
        for k, v in support_2.items():
            for i in k:
                f.write(id2item[i] + ', ')
            f.write(' : ' + str(v) + '\n')
        # 3阶
        f.write('\n三阶: %d\n' % len(support_3))
        for k, v in support_3.items():
            for i in k:
                f.write(id2item[i] + ', ')
            f.write(' : ' + str(v) + '\n')
        # 4阶
        f.write('\n四阶: %d\n' % len(support_4))
        for k, v in support_4.items():
            for i in k:
                f.write(id2item[i] + ', ')
            f.write(' : ' + str(v) + '\n')

        # 关联规则
        f.write('\n关联规则: %d\n' % len(rules))
        for k, v in rules.items():
            if type(k[0]) == int:
                f.write(id2item[k[0]])
            else:
                for i in k[0]:
                    f.write(id2item[i] + ', ')
            f.write(' -> ')
            if type(k[1]) == int:
                f.write(id2item[k[1]])
            else:
                for i in k[1]:
                    f.write(id2item[i] + ', ')
            f.write(' : ' + str(v) + '\n')
