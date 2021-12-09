import axios from 'axios';

export default {

    retrieveExamples() {
        return axios.get('/examples')
    },

    addExample(example) {
        return axios.post('/examples', example)
    }

}