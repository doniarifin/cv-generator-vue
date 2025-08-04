<template>
  <label v-if="label" class="block text-gray-700 mb-2" for="">{{ label }}</label>
  <input
    v-if="type != 'textarea'"
    :type="type"
    :disabled="disabled"
    :placeholder="placeholder"
    v-model="modelValue"
    :class="inputClass"
    @input="$emit('update:modelValue', modelValue)"
  />
  <textarea
    v-else
    :disabled="disabled"
    :placeholder="placeholder"
    v-model="modelValue"
    :class="inputClass"
    @input="$emit('update:modelValue', modelValue)"
  />
</template>

<script setup>
import { ref, watch, computed } from 'vue'

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  type: {
    type: String,
    default: 'text'
  },
  placeholder: {
    type: String,
    default: ''
  },
  class: {
    type: String,
    default: ''
  },
  label: {
    type: String,
    default: null
  },
  disabled: {
    type: Boolean,
    default: false
  },
})

const modelValue = ref(props.modelValue)

// Update local ref if parent changes modelValue
watch(() => props.modelValue, (newVal) => {
  modelValue.value = newVal
})

const inputClass = computed(() => {
  return props.type !== "checkbox" ? `border border-gray-300 px-4 py-2 rounded-md w-full focus:outline-none focus:ring-2 focus:ring-blue-500 ${props.class}` : props.class
})
</script>
