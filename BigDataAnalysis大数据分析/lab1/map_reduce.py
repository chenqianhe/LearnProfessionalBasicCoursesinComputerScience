#!/usr/bin/env python
# -*- coding:utf-8 -*-
# project: lab
# author: Chen Qianhe
# GitHub: https://github.com/chenqianhe
# datetime: 2021/12/3 18:34
import threading

mapper_data = []
reduce_data = []
result = {}


def combine(bigdata):
    combine_data = {}
    for data in bigdata:
        if data[0] not in combine_data.keys():
            combine_data[data[0]] = 0
        combine_data[data[0]] += 1

    return [(data, combine_data[data]) for data in combine_data]


def mapper(path, id):
    print(id)
    part_data = []
    with open(path, "r") as f:  # 打开文件
        lines = f.readlines()  # 读取文件
        for line in lines:
            words = line.replace(" ", "").replace("\n", "").split(",")
            for word in words:
                part_data.append((word, 1))

    mapper_data.extend(combine(part_data))


def reducer(start, end, id):
    print(id)
    count = {}
    for word in mapper_data[start:end]:
        if word[0] not in count.keys():
            count[word[0]] = 0
        count[word[0]] += word[1]

    reduce_data.append(count)


if __name__ == '__main__':
    map_threads = []
    for i in range(1, 10):
        map_threads.append(threading.Thread(target=mapper, args=("./第一次实验/实验一/source数据文件/source0" + str(i), i)))
    for t in map_threads:
        t.setDaemon(True)
        t.start()
    for t in map_threads:
        t.join()

    print((len(mapper_data)))
    print(mapper_data[0])

    mapper_data.sort(key=lambda x: x[0])

    with open("mapper.txt", "w") as f:
        for word in mapper_data:
            f.write(str(word) + "\n")

    reduce_threads = []
    for i in range(3):
        reduce_threads.append(threading.Thread(target=reducer, args=(i * len(mapper_data) // 3, (i + 1) * len(mapper_data) // 3, i)))
    for t in reduce_threads:
        t.setDaemon(True)
        t.start()
    for t in reduce_threads:
        t.join()
    print(len(reduce_data))
    print(reduce_data[0])

    for data in reduce_data:
        for word in data.keys():
            if word not in result.keys():
                result[word] = 0
            result[word] += data[word]

    print(len(result))
    for word in result:
        print(word, result[word])
