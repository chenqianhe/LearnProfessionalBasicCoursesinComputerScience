#!/usr/bin/env python
# -*- coding:utf-8 -*-
# project: lab
# author: Chen Qianhe
# GitHub: https://github.com/chenqianhe
# datetime: 2022/1/3 10:17

from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import TfidfVectorizer
import pandas as pd


if __name__ == '__main__':
    movies_data = pd.read_csv("./大作业/数据集/movies.csv").values.tolist()
    # print(movies_data)
    st = [data[2].replace("|", " ") for data in movies_data if data[2] != "(no genres listed)"]
    # print(st)
    movies_type = set()
    for data in st:
        for movie_type in data.split():
            movies_type.add(movie_type)
    movie_id_trans = {}
    k = 0
    for i in range(len(movies_data)):
        if movies_data[i][2] != "(no genres listed)":
            movie_id_trans[movies_data[i][0]] = k
            k += 1
    # print(movie_id_trans)
    movie_id_trans2 = {movie_id_trans[_id]: _id for _id in movie_id_trans}
    # print(movies_type)
    tfidf = TfidfVectorizer(analyzer=lambda x: x.split(" "))
    res = tfidf.fit_transform(st)
    # print(res)
    # print(tfidf.vocabulary_)
    type_trans = {tfidf.vocabulary_[movie]: movie for movie in tfidf.vocabulary_}
    # print(type_trans)

    print("是否使用minHash(y/N):")
    x = input()
    if x != "N":
        sim = [[0.0 for _ in range(len(res.toarray()))] for _ in range(len(res.toarray()))]
        for i in range(len(res.toarray())):
            set_i = set(st[i].split())
            for j in range(len(res.toarray())):
                set_j = set(st[j].split())
                sim[i][j] = len(set_i & set_j) / len(set_i | set_j)
    else:
        # print(res.toarray())
        sim = cosine_similarity(res.toarray())

    # print(sim)

    train_set = pd.read_csv("./大作业/数据集/train_set.csv").values.tolist()
    userID = set()
    scored = {}
    for data in train_set:
        userID.add(int(data[0]))
        if int(data[0]) not in scored.keys():
            scored[int(data[0])] = []
        scored[int(data[0])].append((int(data[1]), data[2]))

    # print(userID)

    recommend = {}

    print("测试请输入1，推荐输入2：")
    x = int(input())
    if x == 1:
        test_data = pd.read_csv("./大作业/数据集/test_set.csv").values.tolist()
        test_userID = set()
        for data in test_data:
            test_userID.add(int(data[0]))

        for id in test_userID:
            print("正在计算", id)
            recommend_score = [0 for _ in range(len(sim))]
            count = [0 for _ in range(len(sim))]
            for movie in scored[id]:
                if movie[0] in movie_id_trans.keys():
                    _sim = sim[movie_id_trans[movie[0]]]
                    _score = movie[1]
                    for i in range(len(_sim)):
                        if _sim[i] > 0:
                            recommend_score[i] += _score * _sim[i]
                            count[i] += _sim[i]

            temp = []
            for i in range(len(recommend_score)):
                if recommend_score[i] > 0:
                    temp.append((movie_id_trans2[i], recommend_score[i] / count[i]))
            temp.sort(key=lambda x: x[1], reverse=True)
            recommend[id] = temp

        sse = 0.0
        for data in test_data:
            pre_score = 0.0
            for record in recommend[data[0]]:
                if data[1] == record[0]:
                    pre_score = record[1]
                    break
            sse += (pre_score-data[2])**2
            print(int(data[0]), int(data[1]), data[2], pre_score, abs(pre_score-data[2]))
        print("SSE:", sse)
    else:
        print("请输入预测用户id")
        user_id = int(input())
        print("请输入需要推荐前k个电影，k=")
        k = int(input())
        for id in [user_id]:
            recommend_score = [0 for _ in range(len(sim))]
            count = [0 for _ in range(len(sim))]
            for movie in scored[id]:
                if movie[0] in movie_id_trans.keys():
                    _sim = sim[movie_id_trans[movie[0]]]
                    _score = movie[1]
                    for i in range(len(_sim)):
                        if _sim[i] > 0:
                            recommend_score[i] += _score * _sim[i]
                            count[i] += _sim[i]

            temp = []
            for i in range(len(recommend_score)):
                if recommend_score[i] > 0:
                    temp.append((movie_id_trans2[i], recommend_score[i] / count[i]))
            temp.sort(key=lambda x: x[1], reverse=True)
            recommend[id] = temp
        if len(recommend[user_id]) > k:
            for i in range(k):
                print(recommend[user_id][i])
        else:
            for i in range(len(recommend[user_id])):
                print(recommend[user_id][i])








