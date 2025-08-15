import tseslint from 'typescript-eslint';

import { files as ignores } from './ignored_files.json';

export default tseslint.config({
    ignores,
});
