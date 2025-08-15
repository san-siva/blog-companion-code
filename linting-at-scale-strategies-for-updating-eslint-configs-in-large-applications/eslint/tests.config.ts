import tseslint, { configs as tseslintConfigs } from 'typescript-eslint';

import {
	defaultSettings,
	languageOptions,
	testFiles,
	tsRules,
} from './utilities';

export default tseslint.config({
	files: testFiles,
	plugins: {},
	extends: [...tseslintConfigs.recommended],
	rules: tsRules,
	settings: defaultSettings,
	languageOptions,
});
