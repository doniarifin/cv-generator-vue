<template>
  <button
    class="fixed top-1/2 left-0 z-50 transform -translate-y-1/2 bg-gray-700 text-white px-2 py-1 rounded-r-lg opacity-50 hover:opacity-100 transition-opacity duration-300"
    @click="isSidebarOpen = !isSidebarOpen"
  >
    <mdicon
      :name="isSidebarOpen ? 'chevron-left' : 'chevron-right'"
      width="24"
    />
  </button>
  <!-- form field -->
  <div
    class="fixed top-0 left-0 mx-auto h-full w-full md:w-[32rem] bg-gray-100 p-4 overflow-y-auto z-40 transform transition-transform duration-300"
    :class="isSidebarOpen ? 'translate-x-0' : '-translate-x-full'"
  >
    <h2 class="text-2xl p-2 text-center font-bold mb-4">
      CV GENERATOR/BUILDER
    </h2>
    <!-- <h2 class="text-xl font-bold mb-4">Layout</h2>
    <h2 class="text-xl font-bold mb-4">Create Theme</h2> -->
    <h3
      class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer"
      @click="openPersonalDetails"
    >
      Personal Details
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.personalDetailsVisible">
          <mdicon name="chevron-up" width="32" />
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32" />
        </template>
      </button>
    </h3>
    <div v-if="data.personalDetailsVisible">
      <!-- <form @submit.prevent="submitForm"> -->
      <div class="mb-4">
        <label class="block text-gray-700 mb-2" for="uploadPhoto"
          >Profile Picture</label
        >
        <div class="flex">
          <MyUploader
            variant="primary"
            width="w-full"
            class="rounded-md shadow-xl"
            @change="uploadImage"
          />
          <div class="content-center mx-4">
            <MyToggle
              v-model="data.isPhotoProfile"
              :disabled="base64 === null"
              class="rounded-md shadow-xl"
            />
          </div>
        </div>
      </div>
      <div class="mb-4">
        <MyInput
          label="Full Name"
          type="email"
          v-model="data.personalDetails.fullName"
        />
      </div>
      <div class="mb-4">
        <MyInput
          label="Job Title"
          type="email"
          v-model="data.personalDetails.jobTitle"
        />
      </div>
      <div class="mb-4">
        <MyInput
          label="Email"
          type="email"
          v-model="data.personalDetails.email"
        />
      </div>
      <div class="mb-4">
        <MyInput
          label="Phone Number"
          type="phone"
          v-model="data.personalDetails.phone"
        />
      </div>
      <div class="mb-4">
        <MyInput
          label="About"
          type="textarea"
          v-model="data.personalDetails.about"
        />
      </div>
      <!-- <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Submit</button> -->
      <!-- </form> -->
    </div>
    <h3
      class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer"
      @click="openEducation"
    >
      Education
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.isEducationVisible">
          <mdicon name="chevron-up" width="32" />
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32" />
        </template>
      </button>
    </h3>
    <div v-if="data.isEducationVisible">
      <div class="mb-4">
        <template
          v-for="(list, index) in data.eduList"
          :key="'edu' + index + '-' + data.keyEduList"
        >
          <div class="mb-4">
            <div class="flex justify-between">
              <div class="flex">
                <h3 class="block text-gray-700 mb-2 font-bold content-center">
                  Education {{ index + 1 }}
                </h3>
                <button
                  class="text-red-700 px-2 py-1 rounded-lg flex items-center mb-2"
                  @click="delEdulist(index)"
                >
                  <mdicon name="trash-can" width="32" />
                </button>
              </div>
              <button
                class="text-gray-500 px-2 py-1 rounded-lg flex items-center mb-2"
                @click="openListEdu(index)"
              >
                <template v-if="list.EduListVisible">
                  <mdicon name="chevron-up" width="32" />
                </template>
                <template v-else>
                  <mdicon name="chevron-down" width="32" />
                </template>
              </button>
            </div>
            <div v-if="list.EduListVisible">
              <div class="mb-4">
                <MyInput
                  label="School"
                  type="text"
                  v-model="list.EducationSchool"
                />
              </div>
              <div class="mb-4">
                <MyInput
                  label="Field of study"
                  type="text"
                  v-model="list.EducationStudy"
                />
              </div>
              <div class="mb-4">
                <MyInput
                  label="Start date"
                  type="month"
                  v-model="list.EducationStart"
                />
              </div>
              <div class="mb-4">
                <MyInput
                  label="End date"
                  type="month"
                  v-model="list.EducationEnd"
                />
              </div>
              <div class="mb-4">
                <MyInput
                  label="Summary"
                  type="text"
                  v-model="list.EducationSummary"
                />
              </div>
            </div>
          </div>
        </template>

        <MyButton
          label="Add Education"
          class="rounded-md shadow-xl"
          @click="addEducation"
        />
      </div>
    </div>
    <h3
      class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer"
      @click="openSkills"
    >
      Skills & Interests
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.isSkillVisible">
          <mdicon name="chevron-up" width="32" />
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32" />
        </template>
      </button>
    </h3>
    <div v-if="data.isSkillVisible">
      <!-- skillList -->
      <div class="mb-4">
        <div class="flex">
          <label
            class="block text-gray-700 font-bold mb-2"
            for="TechnicalSkills"
            >Technical Skills</label
          >
        </div>
        <div class="flex gap-2">
          <MyInput type="text" v-model="data.skills" />
          <MyButton label="Add" @click="addTechnicalSkill" />
          <!-- <div>
          </div> -->
        </div>
        <div class="flex mt-4">
          <div v-for="(item, index) in data.skillList">
            <div
              class="bg-[#3b82f6] flex gap-2 justify-between items-center text-white shadow appearance-none border rounded py-2 px-3 text-gray-700 text-center"
            >
              <span class="font-bold">
                {{ item }}
              </span>
              <button @click="deleteSkill(item)" class="flex item-center">
                <mdicon name="close" width="20" />
              </button>
            </div>
          </div>
        </div>
      </div>
      <!-- interest -->
      <div class="mb-4">
        <div class="flex">
          <label class="block text-gray-700 font-bold mb-2" for="interest"
            >Interest</label
          >
        </div>
        <div class="flex gap-2">
          <MyInput type="text" v-model="data.interest" />
          <MyButton label="Add" @click="addInterest" />
        </div>
        <div class="flex mt-4">
          <div v-for="(item, index) in data.interestList">
            <div
              class="bg-[#3b82f6] flex gap-2 justify-between items-center text-white shadow appearance-none border rounded py-2 px-3 text-gray-700 text-center"
            >
              <span class="font-bold">
                {{ item }}
              </span>
              <button @click="deleteInterest(item)" class="flex item-center">
                <mdicon name="close" width="20" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <h3
      class="text-xl font-bold mb-4 flex justify-between items-center cursor-pointer"
      @click="openExperience"
    >
      Experiences
      <button class="text-gray-500 px-2 py-1 rounded-lg flex items-center">
        <template v-if="data.isExpVisible">
          <mdicon name="chevron-up" width="32" />
        </template>
        <template v-else>
          <mdicon name="chevron-down" width="32" />
        </template>
      </button>
    </h3>
    <div v-if="data.isExpVisible" class="mb-4">
      <template
        v-for="(list, index) in data.expList"
        :key="'edu' + index + '-' + data.keyExpList"
      >
        <div class="mb-4">
          <div class="flex justify-between">
            <div class="flex">
              <h3 class="block text-gray-700 mb-2 font-bold content-center">
                Experience {{ index + 1 }}
              </h3>
              <button
                class="text-red-700 px-2 py-1 rounded-lg flex items-center mb-2"
                @click="delExplist(index)"
              >
                <mdicon name="trash-can" width="32" />
              </button>
            </div>
            <button
              class="text-gray-500 px-2 py-1 rounded-lg flex items-center mb-2"
              @click="openListExp(index)"
            >
              <template v-if="list.ExpListVisible">
                <mdicon name="chevron-up" width="32" />
              </template>
              <template v-else>
                <mdicon name="chevron-down" width="32" />
              </template>
            </button>
          </div>
          <div v-if="list.ExpListVisible">
            <div class="mb-4">
              <MyInput label="Title" type="text" v-model="list.ExpTitle" />
            </div>
            <div class="mb-4">
              <MyInput
                label="Company Name"
                type="text"
                v-model="list.ExpCompany"
              />
            </div>
            <div class="mb-4 flex gap-2">
              <!-- <input type="checkbox" v-model="list.ExpListCurrentWork"> -->
              <MyInput
                class="width-10px"
                type="checkbox"
                v-model="list.ExpListCurrentWork"
              />
              <span> I am currently working in this role </span>
            </div>
            <div class="mb-4">
              <MyInput
                label="Start date"
                type="month"
                v-model="list.ExpStart"
              />
            </div>
            <div class="mb-4">
              <MyInput
                label="End date"
                type="month"
                v-model="list.ExpEnd"
                :disabled="list.ExpListCurrentWork"
              />
            </div>
            <div class="mb-4">
              <label class="block text-gray-700 mb-2" for="">Summary</label>
              <textarea
                type="text"
                id=""
                v-model="list.ExpSummary"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              ></textarea>
            </div>
          </div>
        </div>
      </template>
      <MyButton
        label="Add Experience"
        class="rounded-md shadow-xl"
        @click="addExp"
      />
    </div>

    <div class="text-center p-10">
      <MyButton
        label="Download CV"
        class="shadow-xl w-[200px]"
        @click="downloadPdf"
      />
    </div>
  </div>

  <div
    class="bg-gray-200 font-normal text-slate-800 text-sm md:relative w-full overflow-y-auto overflow-x-hidden p-6 flex flex-col items-center transition-all duration-300"
    :class="isSidebarOpen ? 'ml-80' : 'ml-0'"
  >
    <div class="p-8 scale-[0.3] md:scale-90">
      <div
        id="cv-to-convert"
        class="bg-[#f8fafc] rounded-lg shadow-lg cv shadow-lg mt-6 bg-white relative grid grid-cols-3"
      >
        <div
          class="bg-gray-100 flex flex-col gap-4 p-6 py-7 col-span-1 bg-slate-50 py-7 rounded"
        >
          <div class="container" v-if="data.isPhotoProfile">
            <img
              :src="data.base64"
              class="object-cover aspect-square max-w-[172px] max-h-[212px] border-white border-8"
              alt="photo-profile"
            />
          </div>
          <div>
            <h1 class="text-primary text-xl uppercase font-bold mb-1">
              {{ data.personalDetails.fullName }}
            </h1>
            <h2 class="text-base uppercase font-bold">
              {{ data.personalDetails.jobTitle }}
            </h2>
          </div>
          <div class="mb-4">
            <h2 class="text-base uppercase font-bold">contact</h2>
            <p class="text-gray-800">{{ data.personalDetails.email }}</p>
            <p class="text-gray-800">{{ data.personalDetails.phone }}</p>
            <p class="text-gray-800">{{ data.personalDetails.location }}</p>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Skills</p>
            <div
              v-if="data.skillList.length !== 0"
              v-for="(item, idx) in data.skillList"
            >
              <p>
                {{ item }}
              </p>
            </div>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Personal Interests</p>
            <div
              v-if="data.interestList.length !== 0"
              v-for="(item, idx) in data.interestList"
            >
              {{ item }}
            </div>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Education</p>
            <div class="mt-4" v-for="(item, idx) in data.eduList">
              <p class="font-bold">{{ item.EducationSchool }}</p>
              {{ item.EducationStudy }} ({{ convertDate(item.EducationStart) }}
              <span
                v-if="item.EducationStart !== '' && item.EducationEnd !== ''"
                >-</span
              >
              {{ convertDate(item.EducationEnd) }})
              <br />
              {{ item.EducationSummary }}
            </div>
          </div>
        </div>
        <div class="pr-8 pl-5 py-8 col-span-2 flex flex-col">
          <div class="mb-4">
            <p class="text-base uppercase font-bold">About Me</p>
            <p class="summary text-sm text-justify">
              {{ data.personalDetails.about }}
            </p>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Experiences</p>
            <div class="mt-4" v-for="(item, idx) in data.expList">
              <p class="font-bold">{{ item.ExpTitle }}</p>
              {{ item.ExpCompany }} ({{ convertDate(item.ExpStart) }}
              <span v-if="item.ExpStart !== ''">-</span>
              <span v-if="item.ExpListCurrentWork">Current</span>
              <span v-else>{{ convertDate(item.ExpEnd) }}</span
              >)
              <br />
              <p class="summary text-sm text-justify">{{ item.ExpSummary }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="m-4 justify-self-center text-center">
      Handcrafted by Doni Arifin <span></span> using VueJS + Tailwind CSS
    </div>
  </div>
</template>

<script setup>
import { reactive, computed, watch, ref } from "vue";
import html2pdf from "html2pdf.js";
import util from "@/assets/js/util";
import MyButton from "../components/MyButton.vue";
import MyInput from "../components/MyInput.vue";
import MyUploader from "../components/MyUploader.vue";
import MyToggle from "../components/MyToggle.vue";

const data = reactive({
  isPhotoProfile: false,
  isShowSkill: false,
  isShowInterest: false,
  base64: null,
  image: null,
  leftWidth: 400,
  isDragging: false,
  personalDetailsVisible: true,
  isSkillVisible: false,
  isExpVisible: false,
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
  },
});

const isSidebarOpen = ref(true);

function uploadImage(evt) {
  let f = evt;
  if (f) {
    createBase64Image(f);
  } else {
    data.base64 = null;
  }
}

function createBase64Image(file) {
  const reader = new FileReader();
  reader.onload = (event) => {
    data.base64 = event.target.result;
  };
  reader.readAsDataURL(file);
  data.isPhotoProfile = true;
}

function convertDate(data) {
  if (data && !isNaN(new Date(data).getTime())) {
    const date = new Date(data);
    const options = { year: "numeric", month: "short" };
    return date.toLocaleString("en-US", options);
  }
  return "Invalid date";
}

function openPersonalDetails() {
  data.personalDetailsVisible = !data.personalDetailsVisible;
}
function openSkills() {
  data.isSkillVisible = !data.isSkillVisible;
}
function openExperience() {
  data.isExpVisible = !data.isExpVisible;
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
  }
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
  }
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

function downloadPdf() {
  const element = document.getElementById("cv-to-convert");
  const fullName = data.personalDetails.fullName;

  const opt = {
    margin: 0,
    filename: fullName ? "CV - " + fullName + ".pdf" : "CV.pdf",
    image: { type: "jpeg", quality: 0.98 },
    html2canvas: { scale: 2 },
    jsPDF: { unit: "in", format: "a4", orientation: "portrait" },
    pagebreak: { mode: ["css", "avoid-all"] },
  };

  html2pdf().set(opt).from(element).save();
}

watch(
  () => data.base64 == null,
  (nv) => {
    if (nv) {
      data.isPhotoProfile = false;
    }
  }
);
</script>

<style scoped>
.cv {
  width: 21cm;
  min-height: 29cm;
  /* padding: 2cm; */
  margin: auto;
  background: white;
  box-shadow: 0 0 0.5cm rgba(0, 0, 0, 0.5);
  font-family: Arial, sans-serif;
  word-break: break-word;
  overflow: hidden;
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
