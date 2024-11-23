<template>
  <!-- form field -->
  <div class="w-full settings basis-1/4 overflow-y-auto min-w-80 bg-gray-100 p-4">
    <h2 class="text-xl font-bold mb-4">CV Generator</h2>
    <h2 class="text-xl font-bold mb-4">Layout</h2>
    <h2 class="text-xl font-bold mb-4">Create Theme</h2>
    <h3 class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer" @click="openPersonalDetails">
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
    <h3 class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer" @click="openEducation">
      Education
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.isEducationVisible">
          <mdicon name="chevron-up" width="32"/>
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32"/>
        </template>
      </button>
    </h3>
    <div v-if="data.isEducationVisible">
      <div class="mb-4">
        <template v-for="(list, index) in data.eduList"
        :key="'edu' + index + '-' + data.keyEduList">
          <div class="mb-4">
            <div class="flex justify-between">
              <div class="flex">
                <h3 class="block text-gray-700 mb-2 font-bold content-center">Education {{ index + 1 }}</h3>
                <button class="text-red-700 px-2 py-1 rounded-lg flex items-center mb-2" @click="delEdulist(index)">
                  <mdicon name="trash-can" width="32"/>
                </button>
              </div>
              <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center mb-2" @click="openListEdu(index)">
                <template v-if="list.EduListVisible">
                  <mdicon name="chevron-up" width="32"/>
                </template>
                <template v-else>
                  <mdicon name="chevron-down" width="32"/>
                </template>
              </button>
            </div>
            <div v-if="list.EduListVisible">
              <div class="mb-4">
                <label class="block text-gray-700 mb-2" for="school">School</label>
                <input type="text" id="" v-model="list.EducationSchool" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 mb-2" for="">Field of study</label>
                <input type="text" id="" v-model="list.EducationStudy" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 mb-2" for="">Start date</label>
                <input type="month" id="" v-model="list.EducationStart" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 mb-2" for="">End date</label>
                <input type="month" id="" v-model="list.EducationEnd" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 mb-2" for="">Summary</label>
                <input type="text" id="" v-model="list.EducationSummary" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
              </div>
            </div>
          </div>
        </template>
        <button @click="addEducation" type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Add Education</button>
      </div>
    </div>
    <h3 class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer" @click="openSkills">
      Skills & Interests
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.isSkillVisible">
          <mdicon name="chevron-up" width="32"/>
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32"/>
        </template>
      </button>
    </h3>
    <div v-if="data.isSkillVisible">
      <!-- skillList -->
      <div class="mb-4">
        <div class="flex">
          <label class="block text-gray-700 font-bold mb-2" for="TechnicalSkills">Technical Skills</label>
          <div class="content-center mx-4">                
            <label class="inline-flex items-center cursor-pointer">
              <input type="checkbox" v-model="data.isShowSkill" class="sr-only peer">
              <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
            </label>
          </div>
        </div>
        <div class="flex">
          <input type="text" id="TechnicalSkills" v-model="data.skills" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          <div class="content-center mx-4">
            <button @click="addTechnicalSkill" type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Add</button>  
          </div>
        </div>
        <div class="flex mt-4">
          <div v-for="(item, index) in data.skillList">
            <div class="bg-[#3b82f6] flex gap-2 justify-between items-center text-white shadow appearance-none border rounded py-2 px-3 text-gray-700 text-center">
              <span class="font-bold">
                {{ item }}
              </span>
              <button @click="deleteSkill(item)" class="flex item-center">
                <mdicon name="close" width="20"/>
              </button>
            </div>
          </div>
        </div>
      </div>
      <!-- interest -->
      <div class="mb-4">
        <div class="flex">
          <label class="block text-gray-700 font-bold mb-2" for="interest">Interest</label>
          <div class="content-center mx-4">                
            <label class="inline-flex items-center cursor-pointer">
              <input type="checkbox" v-model="data.isShowInterest" class="sr-only peer">
              <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
            </label>
          </div>
        </div>
        <div class="flex">
          <input type="text" id="interest" v-model="data.interest" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
          <div class="content-center mx-4">
            <button @click="addInterest" type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Add</button>  
          </div>
        </div>
        <div class="flex mt-4">
          <div v-for="(item, index) in data.interestList">
            <div class="bg-[#3b82f6] flex gap-2 justify-between items-center text-white shadow appearance-none border rounded py-2 px-3 text-gray-700 text-center">
              <span class="font-bold">
                {{ item }}
              </span>
              <button @click="deleteInterest(item)" class="flex item-center">
                <mdicon name="close" width="20"/>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <h3 class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer" @click="openSkills">
      Experiences
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.isSkillVisible">
          <mdicon name="chevron-up" width="32"/>
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32"/>
        </template>
      </button>
    </h3>
    <div class="mb-4">
      <template v-for="(list, index) in data.expList"
      :key="'edu' + index + '-' + data.keyExpList">
        <div class="mb-4">
          <div class="flex justify-between">
            <div class="flex">
              <h3 class="block text-gray-700 mb-2 font-bold content-center">Experience {{ index + 1 }}</h3>
              <button class="text-red-700 px-2 py-1 rounded-lg flex items-center mb-2" @click="delExplist(index)">
                <mdicon name="trash-can" width="32"/>
              </button>
            </div>
            <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center mb-2" @click="openListExp(index)">
              <template v-if="list.ExpListVisible">
                <mdicon name="chevron-up" width="32"/>
              </template>
              <template v-else>
                <mdicon name="chevron-down" width="32"/>
              </template>
            </button>
          </div>
          <div v-if="list.ExpListVisible">
            <div class="mb-4">
              <label class="block text-gray-700 mb-2" for="title">Title</label>
              <input type="text" id="" v-model="list.ExpTitle" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="mb-4">
              <label class="block text-gray-700 mb-2" for="">Company Name</label>
              <input type="text" id="" v-model="list.ExpCompany" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="mb-4">
              <input type="checkbox" v-model="list.ExpListCurrentWork"> I am currently working in this role
            </div>
            <div class="mb-4">
              <label class="block text-gray-700 mb-2" for="">Start date</label>
              <input type="month" id="" v-model="list.ExpStart" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="mb-4">
              <label class="block text-gray-700 mb-2" for="">End date</label>
              <input :disabled="list.ExpListCurrentWork" type="month" id="" v-model="list.ExpEnd" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="mb-4">
              <label class="block text-gray-700 mb-2" for="">Summary</label>
              <textarea type="text" id="" v-model="list.ExpSummary" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
            </div>
          </div>
        </div>
      </template>
      <button @click="addExp" type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Add Experience</button>
    </div>
  </div>

  <div class="bg-gray-200 font-normal text-slate-800 text-sm relative w-full overflow-y-auto overflow-x-hidden p-6 flex flex-col items-center basis-3/4">
    <div class="p-8 ">
      <div class="bg-[#f8fafc] rounded-lg shadow-lg cv shadow-lg mt-6 bg-white relative grid grid-cols-3">
        <div class="bg-gray-100 flex flex-col gap-4 p-6 py-7 col-span-1 bg-slate-50 py-7">
          <div class="container" v-if="data.isPhotoProfile">
            <img :src="data.base64" class="object-cover aspect-square max-w-[172px] max-h-[212px] border-white border-8" alt="photo-profile"/>
          </div>
          <div>
            <h1 class="text-primary text-xl uppercase font-bold mb-1">{{ data.personalDetails.fullName }}</h1>
            <h2 class="text-base uppercase font-bold">{{ data.personalDetails.jobTitle }}</h2>
          </div>
          <div class="mb-4">
            <h2 class="text-base uppercase font-bold">contact</h2>
            <p class="text-gray-800">{{ data.personalDetails.email }}</p>
            <p class="text-gray-800">{{ data.personalDetails.phone }}</p>
            <p class="text-gray-800">{{ data.personalDetails.location }}</p>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Skills</p>
            <div v-if="data.skillList.length !== 0" v-for="(item, idx) in data.skillList">
              <p>
                {{ item }}
              </p>
            </div>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Personal Interests</p>
            <div v-if="data.interestList.length !== 0" v-for="(item, idx) in data.interestList">
              {{ item }}
            </div>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Education</p>
            <div class="mt-4" v-for="(item, idx) in data.eduList">
              <p class="font-bold">{{ item.EducationSchool }}</p>
              {{ item.EducationStudy }} ({{ convertDate(item.EducationStart) }} <span v-if="item.EducationStart !== '' && item.EducationEnd !== ''">-</span> {{ convertDate(item.EducationEnd) }})
              <br/>
              {{ item.EducationSummary }}
            </div>
          </div>
        </div>
        <div class="pr-8 pl-5 py-8 col-span-2 flex flex-col">
          <div class="mb-4">
            <p class="text-base uppercase font-bold">About Me</p>
            <p class="text-gray-700">{{ data.personalDetails.about }}</p>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Experiences</p>
            <div class="mt-4" v-for="(item, idx) in data.expList">
              <p class="font-bold">{{ item.ExpTitle }}</p>
              {{ item.ExpCompany }} ({{ convertDate(item.ExpStart) }} <span v-if="item.ExpStart !== '' && item.ExpEnd !== ''">-</span> {{ convertDate(item.ExpEnd) }})
              <br/>
              <pre class="summary">{{ item.ExpSummary }}</pre>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="m-4 justify-self-center" >
      made by love <span></span> using Vue.js + Tailwind
    </div>
  </div>
</template>

<script setup>
import { reactive, computed, watch } from "vue";
import util from "@/assets/js/util";

const data = reactive({
  isPhotoProfile: false,
  isShowSkill: false,
  isShowInterest: false,
  base64: null,
  image: null,
  leftWidth: 400, 
  isDragging: false,
  personalDetailsVisible: true,
  isSkillVisible: true,
  isEducationVisible: [],
  isEduListVisible: true,
  personalDetails: {
    photoProfile: "",
    jobTitle: "",
    fullName: "",
    email: "",
    phone: "",
    about: "",
  },
  skills: "",
  skillList: [],
  interest: "",
  interestList: [],
  structEducation: [
    {
      EducationSchool: "",
      EducationStudy: "",
      EducationStart: "",
      EducationEnd: "",
      EducationSummary: "",
      EduListVisible: true,
    },
  ],
  eduList: [],
  keyEduList: 0,
  structExp: [
    {
      ExpTitle: "",
      ExpCompany: "",
      ExpStart: "",
      ExpEnd: "",
      ExpSummary: "",
      ExpListCurrentWork: false,
      ExpListVisible: true,
    },
  ],
  expList: [],
  keyExpList: 0,
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

function convertDate(data) {
  if (data && !isNaN(new Date(data).getTime())) {
    const date = new Date(data);
    const options = { year: 'numeric', month: 'short' };
    return date.toLocaleString('en-US', options);
  }
  return "Invalid date";
}

function openPersonalDetails() {
  data.personalDetailsVisible = !data.personalDetailsVisible;
}
function openSkills() {
  data.isSkillVisible = !data.isSkillVisible;
}
function openEducation() {
  data.isEducationVisible = !data.isEducationVisible;
}

function openListEdu(idx) {
  data.eduList[idx].EduListVisible = !data.eduList[idx].EduListVisible;
}

function delEdulist(idx) {
  let allData = data.eduList;
  allData.splice(idx, 1);
}

function addEducation(params) {
  const o = util.cloneObject(data.structEducation);
  data.eduList.push(...o);
}

function openListExp(idx) {
  data.expList[idx].ExpListVisible = !data.expList[idx].ExpListVisible;
}

function delExplist(idx) {
  let allData = data.expList;
  allData.splice(idx, 1);
}

function addExp(params) {
  const o = util.cloneObject(data.structExp);
  data.expList.push(...o);
}

function addTechnicalSkill(params) {
  if (!data.skillList.includes(data.skills)) {
    data.skillList.push(data.skills);
  };
  data.skills = "";
}

function deleteSkill(params) {
  let listSkill = data.skillList;
  console.log(listSkill);
  listSkill.forEach((item, index) => {
    if (item === params) {
      listSkill.splice(index, 1);
    }
  });
}
function addInterest(params) {
  if (!data.interestList.includes(data.interest)) {
    data.interestList.push(data.interest);
  };
  data.interest = "";
}

function deleteInterest(params) {
  let listInterest = data.interestList;
  console.log(listInterest);
  listInterest.forEach((item, index) => {
    if (item === params) {
      listInterest.splice(index, 1);
    }
  });
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
.cv {
  max-width: 21cm;
  min-width: 21cm;
  min-height: 29.69cm;
  word-break: break-word;
  transform: scale(.7);
  transform-origin: top;
}

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
  object-fit: cover;
  min-height: 210px;
  min-width: 210px;
}

.summary {
  max-width: 100%; 
  white-space: pre-wrap; 
  word-break: break-word; 
  overflow-wrap: break-word;
}

</style>
