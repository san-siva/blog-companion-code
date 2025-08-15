import common from './eslint/common.config';
import react from './eslint/react.config';
import tests from './eslint/tests.config';

export default [...common, ...tests, ...react];
