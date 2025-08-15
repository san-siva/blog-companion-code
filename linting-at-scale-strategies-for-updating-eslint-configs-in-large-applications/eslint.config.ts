import legacy from './eslint/legacy.config';
import common from './eslint/common.config';
import react from './eslint/react.config';
import tests from './eslint/tests.config';

export default [...legacy, ...common, ...tests, ...react];
