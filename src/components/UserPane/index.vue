<template>
  <user-info />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import UserInfo from './UserInfo.vue';

export default defineComponent({
  components: {
    UserInfo,
  },
});
</script>
