#!/usr/bin/env python
# -*- coding:utf-8 -*-
# project: lab
# author: Chen Qianhe
# GitHub: https://github.com/chenqianhe
# datetime: 2021/12/17 18:57
import csv


support_min = 0.005
confidence_min = 0.5


def load_data(filename):
    data_set = []
    with open(filename) as f:
        f_csv = csv.reader(f)
        for index, val in enumerate(f_csv):
            if index != 0:
                goods = str(val[1]).replace('}', '').replace('{', '').split(',')
                data_set.append(list(goods))
    return data_set


def pre_process(data_set):
    goods = set()
    for data in data_set:
        for i in data:
            goods.add(i)
    mapping = {}
    i = 0
    for good in goods:
        mapping[good] = i
        i += 1
    for i in range(len(data_set)):
        for j in range(len(data_set[i])):
            data_set[i][j] = mapping[data_set[i][j]]

    data_set = [set(data) for data in data_set]

    return data_set, mapping


def cal_support1(data_set, num):
    support = []
    for i in range(num):
        temp = 0
        for goods in data_set:
            if i in goods:
                temp += 1
        support.append(temp/num)

    return support


def rank1_frequent_itemsets(candidate_set):
    rank1 = {}
    for i in range(len(candidate_set)):
        if candidate_set[i] >= support_min:
            rank1[i] = candidate_set[i]
    return rank1


def rank2_frequent_itemsets(rank1, data_set):
    candidate_set = []
    rank1_keys = list(rank1.keys())
    for i in range(len(rank1_keys)-1):
        for j in range(i+1, len(rank1_keys)):
            candidate_set.append({rank1_keys[i], rank1_keys[j]})
    # print(candidate_set)
    rank2_support = []
    for i in range(len(candidate_set)):
        temp = 0
        for data in data_set:
            if candidate_set[i].issubset(data):
                temp += 1
        rank2_support.append(temp/len(data_set))

    rank2_confidence = []
    for i in range(len(candidate_set)):
        rank2_confidence.append(rank2_support[i]/min(rank1[list(candidate_set[i])[0]], rank1[list(candidate_set[i])[1]]))

    rank2 = []
    final_rank2_support = []
    final_rank2_confidence = []
    for i in range(len(candidate_set)):
        if rank2_support[i] >= support_min:
            rank2.append(candidate_set[i])
            final_rank2_support.append(rank2_support[i])
            final_rank2_confidence.append(rank2_confidence[i])

    return rank2, final_rank2_support, final_rank2_confidence


def rank3_frequent_itemsets(rank2, data_set):
    candidate_set = []
    for i in range(len(rank2) - 1):
        for j in range(i + 1, len(rank2)):
            intersection = rank2[i] | rank2[j]
            if len(intersection) == 3 and intersection not in candidate_set:
                candidate_set.append(intersection)


    rank3_support = []
    for i in range(len(candidate_set)):
        temp = 0
        for data in data_set:
            if candidate_set[i].issubset(data):
                temp += 1
        rank3_support.append(temp / len(data_set))

    rank3 = []
    final_rank3_support = []
    for i in range(len(candidate_set)):
        if rank3_support[i] >= support_min:
            rank3.append(candidate_set[i])
            final_rank3_support.append(rank3_support[i])

    return rank3, rank3_support


if __name__ == '__main__':
    data_set = load_data("./实验三/数据/Groceries.csv")
    data_set, mapping = pre_process(data_set)
    mapping2 = {mapping[i]: i for i in mapping}
    set_num = len(data_set)
    rank1_support = cal_support1(data_set, set_num)
    # print(rank1_support)
    rank1 = rank1_frequent_itemsets(rank1_support)
    print("一阶频繁项集共", len(rank1))
    # for i in rank1:
    #     print(i, mapping2[i], rank1[i])

    rank2, rank2_support, rank2_confidence = rank2_frequent_itemsets(rank1, data_set)

    print("二阶频繁项集共", len(rank2))

    # for i in range(len(rank2)):
    #     print(rank2[i], mapping2[list(rank2[i])[0]], mapping2[list(rank2[i])[1]], rank2_support[i], rank2_confidence[i])

    rank3, rank3_support = rank3_frequent_itemsets(rank2, data_set)

    print("三阶频繁项集共", len(rank3))

    # for i in range(len(rank3)):
    #     print(rank3[i], mapping2[list(rank3[i])[0]], mapping2[list(rank3[i])[1]], mapping2[list(rank3)[2]], rank3_support[i])


    print("一阶频繁项集共", len(rank1))
    print("二阶频繁项集共", len(rank2))
    print("三阶频繁项集共", len(rank3))

