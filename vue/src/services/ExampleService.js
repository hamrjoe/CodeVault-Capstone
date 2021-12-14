import axios from 'axios';

export default {

    retrieveExamples() {
        return axios.get('/examples')
    },

    addExample(exampleToSubmit) {
        return axios.post('/examples', exampleToSubmit);
    },

    deleteExample(exampleId) {
        return axios.delete(`/examples/${exampleId}`);
    },

    editExample(exampleId, example) {
        return axios.put(`/examples/${exampleId}`, example);
    },

    toggleFavorite(exampleId){
        return axios.put(`/examples/${exampleId}/favorite`)
    }

}