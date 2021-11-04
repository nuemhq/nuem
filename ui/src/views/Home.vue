<template>
  <div class="content" style="justify-content: center">
    <div class="hero">
      <h1>Shall we play a game?</h1>
      <h2><a href="#" class="btn">Host</a></h2>
      <p style="text-align: center; font-size: 18px; margin-top: 35px">or</p>
      <p class="room-code-styling">
        <input
          type="text"
          maxlength="8"
          name="room-code"
          class="code-input"
          id="room-code"
          placeholder="Enter room code"
        />
      </p>
      <h2><a href="#" class="btn">Join</a></h2>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: "Home",
  mounted() {
    document.title = "Home - Nuem";
  },
};
</script>
