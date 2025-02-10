module.exports = {
  env: {
    browser: true,
    node: true,
    es2021: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "prettier",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: "latest",
  },
  plugins: ["@typescript-eslint"],
  ignorePatterns: ["*.test.ts", "*.test.js", "lib"],
  rules: {
    "@typescript-eslint/no-explicit-any": "off",
  },
};
