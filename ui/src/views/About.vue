<template>
  <div class="about">
    <h1>This is an about page</h1>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'About',
  mounted() {
    document.title = "About"
  }
}
</script>
