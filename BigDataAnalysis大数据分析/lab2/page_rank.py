#!/usr/bin/env python
# -*- coding:utf-8 -*-
# project: lab
# author: Chen Qianhe
# GitHub: https://github.com/chenqianhe
# datetime: 2021/12/10 18:27
import pandas as pd
import numpy as np

if __name__ == '__main__':
    # 读取数据
    SR = pd.read_csv("sent_receive.csv").values.tolist()
    print(len(SR))
    # 去重, 并确定节点
    edges = []
    nodes = set()
    for data in SR:
        if data not in edges:
            edges.append(data)
        nodes.add(data[0])
        nodes.add(data[1])
    nodes = sorted(list(nodes))
    N = len(nodes)
    print(len(edges))
    # print(nodes)
    print(N)
    # 映射
    index = 0
    node_to_num = {}
    for node in nodes:
        node_to_num[node] = index
        index += 1
    for edge in edges:
        edge[0], edge[1] = node_to_num[edge[0]], node_to_num[edge[1]]
    # print(edges)

    EM = np.zeros([N, N])
    for edge in edges:
        EM[edge[1], edge[0]] = 1
    # print(EM)

    for col in range(N):
        sum_of_col = sum(EM[:, col])
        for row in range(N):
            EM[row, col] = 1 / sum_of_col if EM[row, col] > 0 else 0
    # print(EM)

    alpha = 0.8
    A = alpha * EM + (1 - alpha) / N * np.ones([N, N])
    # print(A)

    # 初始PageRank
    PR_n = np.ones(N) / N
    PR_next = np.zeros(N)

    e = 1
    iter_nums = 0

    while e > 1e-8:
        PR_next = np.dot(A, PR_n)
        e = PR_next - PR_n
        e = max(map(abs, e))
        PR_n = PR_next
        iter_nums += 1
        # print(iter_nums, PR_next)

    # print(PR_n)
    for i in range(len(PR_n)):
        print(PR_n[i], end=" ")
        if i % 7 == 6:
            print()

