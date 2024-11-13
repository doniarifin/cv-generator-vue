<template>
  <div class="w-full h-screen flex">
    <!-- Bagian Kiri: Bisa di-scroll dan Expandable -->
    <div :style="{ width: data.leftWidth + 'px' }" class="h-full overflow-y-scroll bg-gray-100 p-4">
      <h2 class="text-xl font-bold mb-4">CV Generator</h2>
      <h2 class="text-xl font-bold mb-4">Layout</h2>
      <h2 class="text-xl font-bold mb-4">Create Theme</h2>
      <h3 class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer" @click="togglePersonalDetails">
        Personal Details
        <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
          <template v-if="data.personalDetailsVisible">
            <mdicon name="chevron-up" width="32"/>
          </template>
          <template v-else>
            <mdicon name="chevron-down" width="32"/>
          </template>
        </button>
      </h3>
      <div v-if="data.personalDetailsVisible">
        <!-- <form @submit.prevent="submitForm"> -->
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="fullName">Profile Picture</label>
            <div class="flex">
              <label class="upload-photo shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" for="uploader">Upload Photo</label>              
              <input hidden type="file" accept="image/*" id="uploader" @change="uploadImage" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
              <div class="content-center mx-4">                
                <label class="inline-flex items-center cursor-pointer">
                  <input :disabled="data.base64 == null" type="checkbox" v-model="data.isPhotoProfile" class="sr-only peer">
                  <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
                </label>
              </div>
            </div>
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="fullName">Full Name</label>
            <input type="text" id="fullName" v-model="data.personalDetails.fullName" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="JobTitle">Job Title</label>
            <input type="text" id="JobTitle" v-model="data.personalDetails.jobTitle" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="email">Email</label>
            <input type="email" id="email" v-model="data.personalDetails.email" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="phone">Phone Number</label>
            <input type="text" id="phone" v-model="data.personalDetails.phone" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 font-bold mb-2" for="about">About</label>
            <textarea id="about" v-model="data.personalDetails.about" rows="3" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
          </div>
          <!-- <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Submit</button> -->
        <!-- </form> -->
      </div>
      <h3 class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer">
        Skills
      </h3>
    </div>

    <!-- Drag Handle -->
    <div class="drag-handle bg-gray-500" @mousedown="startDragging"></div>

    <div class="overflow-y-scroll bg-gray-200">
      <!-- Bagian Kanan: Tidak Bisa di-scroll -->
      <div :style="{ width: rightWidth + 'px' }" class="bg-gray-200 p-8 flex justify-center items-center">
        <div class="flex bg-[#f8fafc] min-w-[16cm] min-h-[22.7cm] rounded-lg shadow-lg">
          <div class="bg-gray-100 w-1/3 p-4">
            <div class="container" v-if="data.isPhotoProfile">
              <img :src="data.base64" class="object-cover aspect-square max-w-[172px] max-h-[212px] border-white border-8" alt="photo-profile"/>
            </div>
            <h1 class="text-2xl font-bold mb-2 text-center">{{ data.personalDetails.fullName }}</h1>
            <h2 class="text-xl font-semibold text-gray-600 mb-4 text-center">{{ data.personalDetails.jobTitle }}</h2>
            <p class="text-gray-800">CONTACT</p>
            <p class="text-gray-800">{{ data.personalDetails.email }}</p>
            <p class="text-gray-800">{{ data.personalDetails.phone }}</p>
            <p class="text-gray-800">{{ data.personalDetails.location }}</p>
          </div>
          <div class="p-4 w-2/3">
            <p class="text-gray-800">ABOUT ME</p>
            <p class="text-gray-700">{{ data.personalDetails.about }}</p>
          </div>
        </div>
      </div>
      <div class="m-4 justify-self-center" >
        made by love <span></span> using Vue.js + Tailwind
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, computed, watch } from "vue";
const data = reactive({
  isPhotoProfile: false,
  base64: null,
  image: null,
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
});

const rightWidth = computed({
  get() {
    return window.innerWidth - data.leftWidth;
  }
});

function uploadImage(evt) {
  let f = evt.target.files[0]
  if(f) {
    createBase64Image(f);
  } else {
    data.base64 = null;
  }
}

function createBase64Image(file){
  const reader = new FileReader();
  reader.onload = (event) => {
    data.base64 = event.target.result;
  }
  reader.readAsDataURL(file);
  data.isPhotoProfile = true;
}

function startDragging() {
  data.isDragging = true;
  window.addEventListener('mousemove', onMouseMove);
  window.addEventListener('mouseup', stopDragging);
}
function onMouseMove(event) {
  if (data.isDragging) {
    const newWidth = event.clientX;
    data.leftWidth = Math.max(200, Math.min(newWidth, window.innerWidth - 200));
  }
}
function stopDragging() {
  data.isDragging = false;
  window.removeEventListener('mousemove',onMouseMove);
  window.removeEventListener('mouseup', stopDragging);
}
function togglePersonalDetails() {
  data.personalDetailsVisible = !data.personalDetailsVisible;
}

watch(
  () => data.base64 == null,
  (nv) => {
    if (nv) {
      data.isPhotoProfile = false;
    }
  }
)

</script>

<style scoped>
.upload-photo {
  background-color: #3b82f6;
  color: white;
  text-align: center;
  cursor: pointer;
}
.drag-handle {
  width: 5px;
  cursor: ew-resize;
}
.container img {
  object-fit: contain;
}
</style>
