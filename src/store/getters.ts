import { UserInfoType } from '@/types/user';

const getters = {
  userInfo: (state: { user: { info: UserInfoType } }) => state.user.info,
};

export default getters;
