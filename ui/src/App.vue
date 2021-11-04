<template>
  <div id="app">
		<div class="nav">
			<h1>Nuem</h1>
			<div class="menu">
				<router-link to="/create_game">Host Game</router-link>
				<router-link to="/join_game">Join Game</router-link>
				<router-link to="/scenarios">Scenarios</router-link>
				<router-link to="https://nuem.pinnoto.org/community">Community</router-link>
				<router-link to="/settings" v-if="$store.state.user">username</router-link>
        <router-link to="/login" v-if="!$store.state.user">Login</router-link>
        <router-link to="/register" v-if="!$store.state.user">Register</router-link>
			</div>
		</div>
    <router-view/>
  </div>
</template>

<style>
@import './assets/style/style.css'
</style>