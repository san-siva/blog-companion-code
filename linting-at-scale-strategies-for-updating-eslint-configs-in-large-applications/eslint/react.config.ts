import tseslint from 'typescript-eslint';

import {
	defaultExtends,
	languageOptions,
	reactPlugins,
	reactRules,
	reactSettings,
	testFiles,
} from './utilities';

export default tseslint.config({
	files: ['**/*.tsx', '**/*.jsx'],
	ignores: testFiles,
	plugins: reactPlugins,
	extends: defaultExtends,
	rules: reactRules,
	settings: reactSettings,
	languageOptions,
});
