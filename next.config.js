/** @type {import('next').NextConfig} */
const withPWA = require("@imbios/next-pwa")({
  dest: "public",
  disable: process.env.NODE_ENV === 'development',
});

module.exports = withPWA({ output: 'standalone' });
