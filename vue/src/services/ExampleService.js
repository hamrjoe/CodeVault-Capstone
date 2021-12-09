import axios from 'axios';

export default {

    retrieveExamples() {
        return axios.get('/examples')
    },

    addExample(exampleToSubmit) {
        return axios.post('/examples', exampleToSubmit );
    }

}