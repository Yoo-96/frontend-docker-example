<template>
  <div class="user-info">
    <div>name: {{ userInfo.name }}</div>
    <div>desc: {{ userInfo.desc }}</div>
  </div>
</template>
<script lang="ts">
import { defineComponent, ref, onMounted, computed } from 'vue';
import { useStore } from 'vuex';

export default defineComponent({
  props: {
    count: {
      type: String,
      default: null,
    },
  },
  setup(props) {
    const store = useStore();

    const getUserInfo = async (name: string) => {
      store.dispatch('user/getUserInfo', name);
    };

    onMounted(() => {
      getUserInfo('yoo');
    });

    return {
      userInfo: computed(() => store.getters.userInfo),
    };
  },
});
</script>

<style lang="less" scoped>
.user-info {
  color: @primary-color;
}
</style>
