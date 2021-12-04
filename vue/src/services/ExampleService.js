import axios from 'axios';

export default {

    retrieveExamples() {
        return axios.get('/examples')
    }
}