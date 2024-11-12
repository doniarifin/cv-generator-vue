<template>
  <div class="w-full h-screen flex">
    <!-- Bagian Kiri: Bisa di-scroll dan Expandable -->
    <div :style="{ width: leftWidth + 'px' }" class="h-full overflow-y-scroll bg-gray-100 p-4">
      <h2 class="text-xl font-bold mb-4">CV Generator</h2>
      <h2 class="text-xl font-bold mb-4">Layout</h2>
      <h2 class="text-xl font-bold mb-4">Create Theme</h2>
      <h3 class="text-xl font-bold mb-4 flex justify-between items-center">
        Personal Details
        <button @click="togglePersonalDetails" class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
          <template v-if="personalDetailsVisible">
            <mdicon name="chevron-up" width="32"/>
          </template>
          <template v-else>
            <mdicon name="chevron-down" width="32"/>
          </template>
        </button>
      </h3>
      <div v-if="personalDetailsVisible">
        <form @submit.prevent="submitForm">
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="fullName">Profile Picture</label>
            <input type="file" id="photo" v-on:change="personalDetails.photoProfile" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="fullName">Full Name</label>
            <input type="text" id="fullName" v-model="personalDetails.fullName" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="JobTitle">Job Title</label>
            <input type="text" id="JobTitle" v-model="personalDetails.jobTitle" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="email">Email</label>
            <input type="email" id="email" v-model="personalDetails.email" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="phone">Phone Number</label>
            <input type="text" id="phone" v-model="personalDetails.phone" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="about">About</label>
            <textarea id="about" v-model="personalDetails.about" rows="3" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
          </div>
          <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Submit</button>
        </form>
      </div>
    </div>

    <!-- Drag Handle -->
    <div class="drag-handle bg-gray-500" @mousedown="startDragging"></div>

    <div class="overflow-y-scroll bg-gray-200">
      <!-- Bagian Kanan: Tidak Bisa di-scroll -->
      <div :style="{ width: rightWidth + 'px' }" class="bg-gray-200 p-8 flex justify-center items-center">
        <div class="flex bg-[#f8fafc] min-w-[16cm] min-h-[22.7cm] rounded-lg shadow-lg" :style="scaleStyle">
          <div class="bg-gray-100 w-1/3 p-4">
            <div>{{ personalDetails.photoProfile}}</div>
            <h1 class="text-2xl font-bold mb-2 text-center">{{ personalDetails.fullName }}</h1>
            <h2 class="text-xl font-semibold text-gray-600 mb-4 text-center">{{ personalDetails.jobTitle }}</h2>
            <p class="text-gray-800">CONTACT</p>
            <p class="text-gray-800">{{ personalDetails.email }}</p>
            <p class="text-gray-800">{{ personalDetails.phone }}</p>
            <p class="text-gray-800">{{ personalDetails.location }}</p>
          </div>
          <div class="p-4 w-2/3">
            <p class="text-gray-800">ABOUT ME</p>
            <p class="text-gray-700">{{ personalDetails.about }}</p>
          </div>
        </div>
      </div>
      <div class="m-4 justify-self-center" >
        made by love <span></span> using Vue.js + Tailwind
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      leftWidth: 400, 
      isDragging: false,
      personalDetailsVisible: true,
      personalDetails: {
        photoProfile: '',
        jobTitle: '',
        fullName: '',
        email: '',
        phone: '',
        about: '',
      },
    };
  },
  computed: {
    rightWidth() {
      return window.innerWidth - this.leftWidth; 
    },
    // scaleStyle() {
    //   const scale = Math.min(this.rightWidth / 21, window.innerHeight / 29.7);
    //   return {
    //     transform: `scale(${scale})`,
    //     transformOrigin: 'top center',
    //   };
    // },
  },
  methods: {
    startDragging() {
      this.isDragging = true;
      window.addEventListener('mousemove', this.onMouseMove);
      window.addEventListener('mouseup', this.stopDragging);
    },
    onMouseMove(event) {
      if (this.isDragging) {
        const newWidth = event.clientX;
        this.leftWidth = Math.max(200, Math.min(newWidth, window.innerWidth - 200));
      }
    },
    stopDragging() {
      this.isDragging = false;
      window.removeEventListener('mousemove', this.onMouseMove);
      window.removeEventListener('mouseup', this.stopDragging);
    },
    togglePersonalDetails() {
      this.personalDetailsVisible = !this.personalDetailsVisible;
    },
  },
};
</script>

<style scoped>
.drag-handle {
  width: 5px;
  cursor: ew-resize;
}
</style>
