<template>
  <label
    :class="[baseClass, variantClass, widthClass]"
    class="inline-flex cursor-pointer items-center justify-center"
  >
    {{ label }}
    <input hidden type="file" accept="image/*" @change="onFileChange" />
  </label>
</template>

<script setup>
import { computed } from "vue";

const emit = defineEmits(["change"]);

const props = defineProps({
  label: {
    type: String,
    default: "Upload Photo",
  },
  variant: {
    type: String,
    default: "primary", // 'primary' | 'secondary' | 'danger'
  },
  width: {
    type: String,
    default: "", // e.g., 'w-full', 'w-48'
  },
});

const onFileChange = (e) => {
  const file = e.target.files[0];
  emit("change", file);
};

const baseClass = `
  py-2 px-4
  rounded
  text-sm
  font-semibold
  transition-all
  focus:outline-none
  focus:ring-2
  focus:ring-offset-2
`;

const variantClass = computed(() => {
  switch (props.variant) {
    case "primary":
      return "bg-primary text-white bg-primary/80 focus:ring-blue-500";
    case "secondary":
      return "bg-gray-200 text-gray-800 hover:bg-gray-300 focus:ring-gray-400";
    case "danger":
      return "bg-red-500 text-white hover:bg-red-600 focus:ring-red-500";
    default:
      return "bg-primary text-white bg-primary/80 focus:ring-blue-500";
  }
});

const widthClass = computed(() => props.width);
</script>
