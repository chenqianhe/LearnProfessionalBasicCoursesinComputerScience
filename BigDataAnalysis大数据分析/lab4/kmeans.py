#!/usr/bin/env python
# -*- coding:utf-8 -*-
# project: lab
# author: Chen Qianhe
# GitHub: https://github.com/chenqianhe
# datetime: 2021/12/24 18:39
import numpy as np
import pandas as pd
import random

import matplotlib.pyplot as plt


def cal_dist(vec1, vec2):
    return np.linalg.norm(vec1 - vec2)


def process_res(resdata):
    count = {}
    for data in resdata:
        if str(data[0]) not in count:
            count[str(data[0])] = 0
        count[str(data[0])] += 1
    res = [(k, count[k]) for k in count]
    res.sort(key=lambda x: x[1], reverse=True)
    rightpercent = res[0][1] / len(resdata)
    print(res, rightpercent)
    return res[0][1], rightpercent


def draw(l1, l2, l3):

    plt.scatter(l1[:, 1], l1[:, 2], marker='o', alpha=.5)
    plt.scatter(l2[:, 1], l2[:, 2], marker='+', alpha=.5)
    plt.scatter(l3[:, 1], l3[:, 2], marker='^', alpha=.5)
    plt.show()


if __name__ == '__main__':
    data = pd.read_csv("./实验四以及大作业发布/实验四/数据集/WineData.csv", header=None).values.tolist()
    # print(data)
    random.shuffle(data)
    data = np.array(data)
    x1, x2, x3 = data[0][1:], data[1][1:], data[2][1:]
    l1 = []
    l2 = []
    l3 = []
    ITER = 10000
    iter = 0
    while iter < ITER:
        l1 = []
        l2 = []
        l3 = []
        for i in range(len(data)):
            dis1 = cal_dist(data[i, 1:], x1)
            dis2 = cal_dist(data[i, 1:], x2)
            dis3 = cal_dist(data[i, 1:], x3)
            if dis3 <= dis2 and dis3 <= dis1:
                l3.append(data[i])
            elif dis2 <= dis3 and dis2 <= dis1:
                l2.append(data[i])
            else:
                l1.append(data[i])
        new_x1 = sum(np.array(l1)[:, 1:]) / len(l1)
        new_x2 = sum(np.array(l2)[:, 1:]) / len(l2)
        new_x3 = sum(np.array(l3)[:, 1:]) / len(l3)
        if cal_dist(x1, new_x1) <= 0.00000001 and cal_dist(x2, new_x2) <= 0.00000001 and cal_dist(x3, new_x3) <= 0.00000001:
            print("变化较小")
            print(iter)
            break
        else:
            x1, x2, x3 = new_x1, new_x2, new_x3
            iter += 1

    # print(x1)
    # print(x2)
    # print(x3)
    # print(len(l1))
    # print(len(l2))
    # print(len(l3))
    restype1, right1 = process_res(l1)
    restype2, right2 = process_res(l2)
    restype3, right3 = process_res(l3)
    print("准确率：", sum([right3, right2, right1]) / 3)
    dis = 0.0
    for data in l1:
        dis += cal_dist(x1, data[1:])
    for data in l2:
        dis += cal_dist(x2, data[1:])
    for data in l3:
        dis += cal_dist(x3, data[1:])
    print("总距离：", dis)
    draw(np.array(l1), np.array(l2), np.array(l3))
