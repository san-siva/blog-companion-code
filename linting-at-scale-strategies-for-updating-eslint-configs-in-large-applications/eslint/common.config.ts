import tseslint, { configs as tseslintConfigs } from 'typescript-eslint';

import {
	defaultExtends,
	defaultPlugins,
	defaultRules,
	defaultSettings,
	languageOptions,
	testFiles,
	tsRules,
} from './utilities';

export default tseslint.config(
	{
		ignores: [
			'package-lock.json',
			'yarn.lock',
			'node_modules/**',
			'.firebase/**',
			'.next/**',
			'out/**',
			'next-env.d.ts'
		],
	},
	{
		files: ['**/*.ts', '**/*.js'],
		ignores: testFiles,
		plugins: defaultPlugins,
		extends: defaultExtends,
		rules: defaultRules,
		settings: defaultSettings,
		languageOptions,
	},
	{
		files: testFiles,
		plugins: {},
		extends: [...tseslintConfigs.recommended],
		rules: tsRules,
		settings: defaultSettings,
		languageOptions,
	},
	{
		files: ['eslint.config.ts', 'eslint/**/*.ts'],
		extends: [tseslintConfigs.disableTypeChecked],
	}
);
