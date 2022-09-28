<template>
  <button @click="toPage('home')">to home page</button>

  <button @click="toPage('user')">to user page</button>
  <br />
  <br />
  <br />
  <router-view></router-view>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { useRouter } from 'vue-router';

export default defineComponent({
  setup() {
    const router = useRouter();
    const toPage = (name: string) => {
      router.push({
        name,
      });
    };
    return {
      toPage,
    };
  },
});
</script>

<style></style>
