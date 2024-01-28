import type { Config } from 'tailwindcss';
import colors from 'tailwindcss/colors';

export default {
  content: ['./theme/**/*.ftl'],
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms'), require('kutty')],
  theme: {
    extend: {
      colors: {
        primary: {
          '50': '#F9F5FF',
          '100': '#F4EBFF',
          '200': '#E9D7FE',
          '300': '#D6BBFB',
          '400': '#B692F6',
          '500': '#9E77ED',
          '600': '#7F56D9',
          '700': '#6941C6',
          '800': '#53389E',
          '900': '#42307D ',
          '950': '#AA483',
        },
        secondary: colors.gray,

        provider: {
          apple: '#000000',
          bitbucket: '#0052CC',
          discord: '#5865F2',
          facebook: '#1877F2',
          github: '#181717',
          gitlab: '#FC6D26',
          google: '#4285F4',
          instagram: '#E4405F',
          linkedin: '#0A66C2',
          microsoft: '#5E5E5E',
          oidc: '#F78C40',
          openshift: '#EE0000',
          paypal: '#00457C',
          slack: '#4A154B',
          stackoverflow: '#F58025',
          twitter: '#1DA1F2',
        },
      },
    },
  },
} satisfies Config;
