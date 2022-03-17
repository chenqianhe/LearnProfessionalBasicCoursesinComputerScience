import numpy as np
import pandas as pd


def cf_recommend(mode, matrix, k, user_id, movie_id, n):
    n_user = len(matrix.iloc[0])
    sim_dict = {i: matrix[user_id].corr(matrix[i], method='pearson') for i in range(1, n_user + 1)}
    sorted_sim = sorted(sim_dict.items(), key=lambda d: d[1], reverse=True)
    sim_id = [sorted_sim[i][0] for i in range(k)]
    sim_matrix = matrix[sim_id]
    if mode == 0:
        x = sim_matrix.loc[movie_id]
        pred_score = np.mean(x[x != 0])
        return pred_score
    else:
        pred_movie_dict = {}
        for i in range(len(matrix)):
            x = sim_matrix.iloc[i]
            if len(x[x != 0]) > 15:
                pred_score = np.mean(x[x != 0])
                pred_movie_dict[i] = 0 if np.isnan(pred_score) else pred_score
            else:
                pred_movie_dict[i] = 0
        sorted_pred = sorted(pred_movie_dict.items(), key=lambda d: d[1], reverse=True)
        pred = sorted_pred[:n]
        return pred


def cf_mini_hash(mode, matrix, binary_matrix, num_func, k, user_id, movie_id, n):
    n_user = len(binary_matrix.columns)
    n_movie = len(binary_matrix[1])
    matrix_sign = np.zeros((num_func, n_user))
    for i in range(num_func):
        function = list(range(1, n_movie + 1))
        np.random.shuffle(function)
        shuffled_matrix = binary_matrix.reindex(function)
        t_s = set(range(n_user))
        t_sig = np.zeros(n_user)
        for j in range(n_movie):
            row = np.array(shuffled_matrix.iloc[j])
            for r in range(n_user):
                if row[r] and r in t_s:
                    t_s.remove(r)
                    t_sig[r] = j + 1
            if not t_s:
                break
        matrix_sign[i] = t_sig
    matrix_sign = pd.DataFrame(matrix_sign)
    matrix_sign.columns = list(range(1, n_user + 1))
    sim_dict = {i: np.sum(matrix_sign[user_id] == matrix_sign[i]) / num_func for i in range(1, n_user + 1)}
    sorted_sim = sorted(sim_dict.items(), key=lambda d: d[1], reverse=True)
    sim_id = [sorted_sim[i][0] for i in range(k)]
    sim_matrix = matrix[sim_id]
    if mode == 0:
        x = sim_matrix.loc[movie_id]
        if len(x[x != 0]) == 0:
            return 2.5
        pred_score = np.mean(x[x != 0])
        return pred_score
    else:
        pred_movie_dict = {}
        for i in range(len(matrix)):
            x = sim_matrix.iloc[i]
            if len(x[x != 0]) > 15:
                pred_score = np.mean(x[x != 0])
                pred_movie_dict[i] = 0 if np.isnan(pred_score) else pred_score
            else:
                pred_movie_dict[i] = 0
        sorted_pred = sorted(pred_movie_dict.items(), key=lambda d: d[1], reverse=True)
        pred = sorted_pred[:n]
        return pred


def run():
    k = 50
    user_id = 671
    n = 10
    num_func = 1000
    # 未用mini-hash
    print("未用mini-hash")
    train_data = pd.read_csv('data/train_set.csv')
    train_matrix = train_data.pivot_table(index=['movieId'], columns=['userId'], values='rating').reset_index(drop=True)
    train_matrix.fillna(0, inplace=True)
    train_matrix.index = np.array(sorted(train_data['movieId'].unique()))

    pred = cf_recommend(1, train_matrix, k, user_id, 0, n)
    for i in range(n):
        movie_id, score = pred[i]
        print("{:6d}:{:.4f}".format(train_matrix.index[movie_id], score))
    test_data = pd.read_csv('data/test_set.csv')
    users, movies, ratings = test_data['userId'], test_data['movieId'], test_data['rating']
    pred_scores = []
    SSE = 0.0
    for i in range(len(test_data)):
        print('\r%d/%d' % (i + 1, len(test_data)), end="")
        pred_score = cf_recommend(0, train_matrix, k, users[i], movies[i], n)
        SSE += (pred_score - ratings[i]) ** 2
        pred_scores.append(pred_score)
    print("\nSSE:{:.4f}".format(SSE))

    # 使用mini-hash
    print("使用mini-hash")
    mini_hash_data = pd.read_csv('data/train_set.csv')
    for i in range(mini_hash_data.shape[0]):
        if mini_hash_data.iat[i, 2] <= 2.5:
            mini_hash_data.iat[i, 2] = 0
        else:
            mini_hash_data.iat[i, 2] = 1
    mini_hash_matrix = mini_hash_data.pivot_table(index=['movieId'], columns=['userId'], values='rating').reset_index(
        drop=True)
    mini_hash_matrix.fillna(0, inplace=True)
    mini_hash_matrix.index = np.array(sorted(mini_hash_data['movieId'].unique()))
    binary_matrix = mini_hash_data.pivot_table(index=['movieId'], columns=['userId'], values='rating').reset_index(
        drop=True)
    binary_matrix.fillna(0, inplace=True)
    binary_matrix.index = np.array(sorted(mini_hash_data['movieId'].unique()))
    pred = cf_mini_hash(1, train_matrix, binary_matrix, num_func, k, user_id, 0, n)
    for i in range(n):
        movie_id, score = pred[i]
        print("{:6d}:{:.4f}".format(train_matrix.index[movie_id], score))
    test_data = pd.read_csv('data/test_set.csv')
    users, movies, ratings = test_data['userId'], test_data['movieId'], test_data['rating']
    pred_scores = []
    SSE = 0.0
    for i in range(len(test_data)):
        print('\r%d/%d' % (i + 1, len(test_data)), end="")
        pred_score = cf_mini_hash(0, train_matrix, binary_matrix, num_func, k, users[i], movies[i], n)
        # print(pred_score)
        SSE += (pred_score - ratings[i]) ** 2
        pred_scores.append(pred_score)
    print("\nSSE:{:.4f}".format(SSE))


if __name__ == '__main__':
    run()
