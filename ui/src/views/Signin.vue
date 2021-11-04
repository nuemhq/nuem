<template>
  <div class="content" style="justify-content: center">
    <div class="auth-box">
      <div class="login">
        <h1>Login to your account</h1>
        <input type="text" class="text-input" placeholder="Username" v-model="login.username" />
        <input type="password" class="text-input" placeholder="Password" v-model="login.password" />
        <a @click="doLogin" class="btn">Sign in</a>
      </div>
      <p style="margin-top: 60px;">or</p>
      <div class="signup">
        <h1>Create an account</h1>
        <input type="text" class="text-input" placeholder="Username" v-model="register.username" />
        <input type="text" class="text-input" placeholder="E-mail" v-model="register.email" />
        <input type="password" class="text-input" placeholder="Password" v-model="register.password" />
        <div class="colors">
          <div class="color" v-for="color in colors" :key="color.id" @click="register.color = color.id" :class="{ selected: register.color === color.id }">
            <div
              class="acolor"
              style="width: 20px; height: 20px"
              :style="'background-color: var(--' + color.color + ')'"
              />
            <p>{{ color.name }}</p>
            <!--<input type="radio" v-model="register.color" :value="color.id" />-->
          </div>
        </div>
        <p v-if="error">{{error}}</p>
        <a @click="doRegister" class="btn">Sign up</a>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "Signup",
  data() {
    return {
        error: "",
      colors: [
        {
          id: 1,
          name: "Pinnoto Red",
          color: "pinnoto-pm",
        },
        {
          id: 2,
          name: "Red",
          color: "red-pm",
        },
        {
          id: 3,
          name: "Orange",
          color: "orange-pm",
        },
        {
          id: 4,
          name: "Gold",
          color: "gold-pm",
        },
        {
          id: 5,
          name: "Yellow",
          color: "yellow-pm",
        },
        {
          id: 6,
          name: "Lime",
          color: "lime-pm",
        },
        {
          id: 7,
          name: "Green",
          color: "green-pm",
        },
        {
          id: 8,
          name: "Dark Green",
          color: "dark-green-pm",
        },
        {
          id: 9,
          name: "Turquoise",
          color: "turquoise-pm",
        },
        {
          id: 10,
          name: "Electric Blue",
          color: "electric-pm",
        },
        {
          id: 11,
          name: "Aqua",
          color: "aqua-pm",
        },
        {
          id: 12,
          name: "Blue",
          color: "blue-pm",
        },
        {
          id: 13,
          name: "Dark Blue",
          color: "navy-pm",
        },
        {
          id: 14,
          name: "Purple",
          color: "purple-pm",
        },
        {
          id: 15,
          name: "Magenta",
          color: "magenta-pm",
        },
        {
          id: 16,
          name: "Pink",
          color: "pink-pm",
        },
        {
          id: 17,
          name: "Lobster",
          color: "lobster-pm",
        },
        {
          id: 18,
          name: "Dark Rose",
          color: "dark-rose-pm",
        },
      ],
      login: {
        username: "",
        password: "",
      },
      register: {
        username: "",
        email: "",
        password: "",
        color: 0
      },
    };
  },
  methods: {
    doLogin() {
      this.axios
        .post("/api/login", {
          ...this.login,
        })
        .then((res) => {
          localStorage.setItem("token", res.data.token);
          Object.assign(this.axios.defaults, {
            headers: { Authorization: localStorage.getItem("token") },
          });
        this.axios.get('/api/userinfo').then((res) => {
			this.$store.commit('setUser', res.data)
		})
        this.$router.push('/')
        });
    },
    doRegister() {
      this.axios
        .post("/api/register", {
          ...this.register,
        })
        .then((res) => {
          localStorage.setItem("token", res.data.token);
          Object.assign(this.axios.defaults, {
            headers: { Authorization: localStorage.getItem("token") },
          });
        this.axios.get('/api/userinfo').then((res) => {
			this.$store.commit('setUser', res.data)
		})
        this.$router.push('/')
        }).catch((e) => {
            this.error = e.response.data.message
        });
    },
  },
};
</script>
