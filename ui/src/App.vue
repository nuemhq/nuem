<template>
  <div id="app">
		<div class="nav">
			<router-link to="/"><h1>Nuem</h1></router-link>
			<div class="menu">
				<router-link to="/create_game">Host Game</router-link>
				<router-link to="/join">Join Game</router-link>
				<router-link to="/scenarios">Scenarios</router-link>
				<router-link to="https://nuem.pinnoto.org/community">Community</router-link>
				<router-link to="/settings" v-if="$store.state.user">{{$store.state.user.username}}</router-link>
				<router-link to="/signin" v-if="!$store.state.user">Sign in</router-link>
			</div>
		</div>
    <router-view/>
  </div>
</template>
<script>

export default {
	name: "App",
	mounted() {
		Object.assign(this.axios.defaults, {
            headers: { Authorization: localStorage.getItem("token") },
        });
		this.axios.get('/api/userinfo').then((res) => {
			this.$store.commit('setUser', res.data)
		})
	},
	watch: {
		$route(to) {
			document.title = to.name + " - Nuem"
		}
	}
}
</script>
