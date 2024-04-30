const express = require('express');
const admin = require('firebase-admin');
const { MongoClient } = require('mongodb');
require('dotenv').config();

const serviceAccount = require('./cruddbkey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const app = express();
const PORT = 3100;

let client;

async function getConnection() {
    if (!client) {
        client = new MongoClient(process.env.DOCKER_URI);
        client.on('connected', () => {
            console.log('Connected to MongoDB Atlas');
        });
        client.on('disconnected', () => {
            console.log('Disconnected from MongoDB Atlas');
        });
        try {
            await client.connect();
        } catch (error) {
            console.error('Error connecting to MongoDB Atlas:', error);
            throw error;
        }
    }
    return client;
}

app.use(express.json());

app.post('/delete', async (req, res) => {
    const {
        numeroDocumento
    } = req.body.data;

    const connection = await getConnection();
    const collection = connection.db('MainDB').collection('usuarios');
    const logCollection = connection.db('MainDB').collection('log');

    try {
        if(!numeroDocumento){
           return res.status(400).json({ result: 'verificar vacio'});
        }
        const doc = await collection.findOne({ numeroDocumento: numeroDocumento });
        
        if (!doc) {
            return res.status(400).json({ result: 'verificar inexistente'});
        }

        await collection.deleteOne({ numeroDocumento: numeroDocumento });

        // Crear el registro en el log
        await logCollection.insertOne({
            id: numeroDocumento,
            tipo: 'delete',
            fecha: new Date()
        });    

        return res.status(200).json({ result: 'exito' });
    } catch (error) {
        return res.status(500).json({ result: 'error' });
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
