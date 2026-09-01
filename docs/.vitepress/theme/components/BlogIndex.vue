<script setup>
import { data as posts } from '../../../blog.data.js'
</script>

<template>
  <div class="blog-list">
    <a
      v-for="post in posts"
      :key="post.url"
      :href="post.url"
      class="blog-post"
    >
      <h2>{{ post.title }}</h2>
      <time v-if="post.date">{{ post.date }}</time>
    </a>
  </div>
</template>