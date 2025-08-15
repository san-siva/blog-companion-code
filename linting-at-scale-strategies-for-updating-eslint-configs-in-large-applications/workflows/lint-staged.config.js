export default {
    '**/*.{js,jsx,ts,tsx}': async (files) => {
        if (files.length === 0) return [];
        return [
            `prettier --loglevel silent --write ${files.join(' ')}`,
            `eslint -f compact --quiet --no-warn-ignored ${files.join(' ')}`,
        ];
    },
};
