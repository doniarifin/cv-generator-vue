<template>
  <button
    :type="type"
    :class="[baseClass, variantClass, width && width]"
    @click="emit('click')"
  >
    <slot>{{ label }}</slot>
  </button>
</template>

<script setup>
import { computed } from "vue";

const emit = defineEmits({
  click: null,
});

const props = defineProps({
  type: {
    type: String,
    default: "button",
  },
  variant: {
    type: String,
    default: "primary",
  },
  label: {
    type: String,
    default: "Submit",
  },
  width: {
    type: String,
    default: "",
  },
});

const baseClass = `
  px-5 py-2.5
  rounded-md
  text-sm
  font-medium
  transition
  focus:outline-none
  focus:ring-2
  focus:ring-offset-2
`;

const variantClass = computed(() => {
  switch (props.variant) {
    case "primary":
      return "bg-primary text-white hover:bg-primary/80 focus:ring-primary";
    case "secondary":
      return "bg-gray-200 text-gray-800 hover:bg-gray-300 focus:ring-gray-400";
    case "danger":
      return "bg-red-500 text-white hover:bg-red-600 focus:ring-red-500";
    default:
      return "bg-primary text-white hover:bg-primary/80 focus:ring-primary";
  }
});
</script>
