<template>
    <div class="content" style="justify-content: center">
        <div class="auth-box">
            <div class="login">
                <p>Username</p>
                <input type="text" class="text-input">
                <p>Password</p>
                <input type="password" class="text-input">
                <a href="" class="btn">Sign in</a>
            </div>
            <div class="signup">
                <p>Username</p>
                <input type="text" class="text-input">
                <p>Email</p>
                <input type="password" class="text-input">
                <p>Password</p>
                <input type="password" class="text-input">
                <p>Preferred color</p>
                <div class="colors">
                    <div class="color" v-for="color in colors" :key="color.id">
                        <div class="acolor" style="width: 20px;height:20px;" :style="'background-color: var(--'+ color.color +')'"/>
                        <p>{{color.name}}</p>
                        <input type="radio" v-model="selectedColor" :value="color.id"/>
                    </div>
                </div>
                <a href="" class="btn">Sign up</a>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    name: "Signup",
    data() {
        return {
            selectedColor: 1,
            colors: [
                {
                    id: 1,
                    name: "Dark Rose",
                    color: "dark-rose-pm"
                },                
                {
                    id: 2,
                    name: "Pinnoto Red",
                    color: "pinnoto-pm"
                },
                {
                    id: 3,
                    name: "Orange",
                    color: "orange-pm"
                },
                {
                    id: 4,
                    name: "Gold",
                    color: "gold-pm"
                },
                {
                    id: 5,
                    name: "Yellow",
                    color: "yellow-pm"
                },
                {
                    id: 6,
                    name: "Lime",
                    color: "lime-pm"
                },
                {
                    id: 7,
                    name: "Green",
                    color: "green-pm"
                },
                {
                    id: 8,
                    name: "Dark Green",
                    color: "dark-green-pm"
                },
                {
                    id: 9,
                    name: "Turquoise",
                    color: "turquoise-pm"
                },
                {
                    id: 10,
                    name: "Electric Blue",
                    color: "electric-pm"
                },
                {
                    id: 11,
                    name: "Aqua",
                    color: "aqua-pm"
                },
                {
                    id: 12,
                    name: "Blue",
                    color: "blue-pm"
                },
                {
                    id: 13,
                    name: "Dark Blue",
                    color: "navy-pm"
                },
                {
                    id: 14,
                    name: "Purple",
                    color: "purple-pm"
                },
                {
                    id: 15,
                    name: "Magenta",
                    color: "magenta-pm"
                },
                {
                    id: 16,
                    name: "Pink",
                    color: "pink-pm"
                },
                {
                    id: 17,
                    name: "Lobster",
                    color: "lobster-pm"
                }
            ]
        }
    }    
}
</script>
