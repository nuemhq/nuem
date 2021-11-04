<template>
    <div class="content">
        <div class="bar-left">
            <div class="actions">
                <div id="inspect">

                </div>
                <div id="transfer">

                </div>
                <div id="reinforce">

                </div>
            </div>
        </div>
        <div class="middle-box">
            <div class="game-box">
				<div id="map"></div>
			</div>
            <div class="bar-bottom">
                <input type="range" min="1" max="60" value="20" @click="moveSlider('x')" v-model="x"/>
                <input type="range" min="1" max="40" value="10" @click="moveSlider('y')" v-model="y"/>
            </div>
        </div>
        <div class="bar-right">
            <div class="orders">

            </div>
            <div class="players">

            </div>
        </div>
    </div>
</template>
<script>
//import Raphael from 'raphael'
export default {
  data() {
    return {
      x: 0,
      y: 0,
    };
  },
	mounted() {
	}
}
</script>