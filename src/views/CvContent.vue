<template>
  <div
    class="bg-gray-200 font-normal text-slate-800 text-sm md:relative w-full overflow-y-auto overflow-x-hidden p-6 flex flex-col items-center transition-all duration-300"
    :class="props.sideBarOpen ? 'ml-80' : 'ml-0'"
  >
    <div class="p-8 scale-[0.3] md:scale-90">
      <div
        id="cv-to-convert"
        class="bg-[#f8fafc] rounded-lg shadow-lg cv shadow-lg mt-6 bg-white relative grid grid-cols-3"
      >
        <div
          class="bg-gray-100 flex flex-col gap-4 p-6 py-7 col-span-1 bg-slate-50 py-7 rounded"
        >
          <div class="container" v-if="props.datas.isPhotoProfile">
            <img
              :src="props.datas.base64"
              class="object-cover aspect-square max-w-[172px] max-h-[212px] border-white border-8"
              alt="photo-profile"
            />
          </div>
          <div>
            <h1 class="text-primary text-xl uppercase font-bold mb-1">
              {{ props.datas.personalDetails.fullName }}
            </h1>
            <h2 class="text-base uppercase font-bold">
              {{ props.datas.personalDetails.jobTitle }}
            </h2>
          </div>
          <div class="mb-4">
            <h2 class="text-base uppercase font-bold">contact</h2>
            <p class="text-gray-800">{{ props.datas.personalDetails.email }}</p>
            <p class="text-gray-800">{{ props.datas.personalDetails.phone }}</p>
            <p class="text-gray-800">
              {{ props.datas.personalDetails.location }}
            </p>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Skills</p>
            <div
              v-if="props.datas.skillList.length !== 0"
              v-for="(item, idx) in props.datas.skillList"
            >
              <p>
                {{ item }}
              </p>
            </div>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Personal Interests</p>
            <div
              v-if="props.datas.interestList.length !== 0"
              v-for="(item, idx) in props.datas.interestList"
            >
              {{ item }}
            </div>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Education</p>
            <div class="mt-4" v-for="(item, idx) in props.datas.eduList">
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
              {{ props.datas.personalDetails.about }}
            </p>
          </div>
          <div class="mb-4">
            <p class="text-base uppercase font-bold">Experiences</p>
            <div class="mt-4" v-for="(item, idx) in props.datas.expList">
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

const props = defineProps({
  datas: { type: Object, default: () => {} },
  sideBarOpen: { type: Boolean, default: true },
});

function convertDate(data) {
  if (data && !isNaN(new Date(data).getTime())) {
    const date = new Date(data);
    const options = { year: "numeric", month: "short" };
    return date.toLocaleString("en-US", options);
  }
  return "";
}
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
