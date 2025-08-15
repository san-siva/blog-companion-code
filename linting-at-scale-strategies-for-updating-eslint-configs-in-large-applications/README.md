## 🛠️ How to Use
1. Copy Configuration Files
Navigate to the relevant directory and copy the configuration files to your project.

2. Install Dependencies
Use the provided installation commands for each configuration.

3. Customize Rules
Modify the rules in utilities.ts to match your project's requirements.

4. Follow the [Blog](https://santhoshsiva.dev/blog/linting-at-scale-strategies-for-updating-eslint-configs-in-large-applications/) Post
Each configuration corresponds to a detailed blog post explaining the setup and reasoning.

### Installation:

```bash
yarn add --dev \
  eslint \
  eslint-config-next \
  @typescript-eslint/eslint-plugin \
  @typescript-eslint/parser \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  eslint-plugin-jsx-a11y \
  eslint-plugin-import \
  eslint-plugin-simple-import-sort \
  eslint-plugin-unicorn \
  eslint-config-prettier \
  eslint-plugin-prettier \
  eslint-plugin-no-await-in-promise \
  typescript-eslint \
  jiti
```

### Usage:

```js
javascript
// eslint.config.js
import tseslint from 'typescript-eslint';
import { defaultExtends, reactPlugins, reactRules, reactSettings, languageOptions } from './path/to/utilities';

export default tseslint.config({
  files: ['**/*.tsx', '**/*.ts'],
  plugins: reactPlugins,
  extends: defaultExtends,
  rules: reactRules,
  settings: reactSettings,
  languageOptions,
});
```
