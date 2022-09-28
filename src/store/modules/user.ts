import { UserInfoType } from '@/types/user';

import { fetchUsetInfo } from '@/api/user';

const userStore = {
  namespaced: true,
  state() {
    return {
      info: {
        name: '',
        desc: '',
      },
    };
  },
  mutations: {
    SET_USER_INFO(state: any, info: UserInfoType) {
      state.info = info;
    },
  },
  actions: {
    getUserInfo({ commit }: any, name: string) {
      return new Promise((resolve, reject) => {
        fetchUsetInfo(name)
          .then((response) => {
            commit('SET_USER_INFO', response);
            resolve(response);
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
  },
};

export default userStore;
