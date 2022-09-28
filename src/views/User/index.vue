<template>
  user page
  <user-pane />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import UserPane from '@/components/UserPane/index.vue';

export default defineComponent({
  components: {
    UserPane,
  },
});
</script>
