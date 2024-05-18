const express = require('express');
const admin = require('firebase-admin');
const { MongoClient } = require('mongodb');
require('dotenv').config();

const serviceAccount = require('./cruddbkey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const app = express();
const PORT = 3000;

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

app.options('/create', (req, res) => {
    // Set CORS headers for preflight requests
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:1200'); // Replace with your client's origin
    res.setHeader('Access-Control-Allow-Methods', 'POST'); // Allow POST requests
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type'); // Allow Content-Type header
    res.status(200).end();
});

app.post('/create', async (req, res) => {
    const {
        urlFoto,
        tipoDocumento,
        numeroDocumento,
        primerNombre,
        segundoNombre,
        apellidos,
        fechaNacimiento,
        genero,
        correo,
        celular
    } = req.body.data;

    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:1200'); // Replace with your client's origin
    res.setHeader('Access-Control-Allow-Methods', 'POST'); // Allow POST requests
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type'); // Allow Content-Type header

    function formatDate(date) { 
        // Obtener las partes de la fecha
        const anio = date.toLocaleString('es-ES', { year: 'numeric', timeZone: 'America/Bogota' });
        const mes = date.toLocaleString('es-ES', { month: '2-digit', timeZone: 'America/Bogota' });
        const dia = date.toLocaleString('es-ES', { day: '2-digit', timeZone: 'America/Bogota' });
        return `${dia}-${mes}-${anio}`; 
      }

    const connection = await getConnection();
    const collection = connection.db('MainDB').collection('usuarios');
    const logCollection = connection.db('MainDB').collection('log');

    if (!urlFoto || !tipoDocumento || !numeroDocumento || !primerNombre || !apellidos || !fechaNacimiento || !genero || !correo || !celular) {
        return res.status(200).json({ result: 'verificar' });
    }

    // Process photo URL
    let urlFoto2 = urlFoto.replace('https://firebasestorage.googleapis.com/v0/b/crud-db-e2974.appspot.com/o/', '');
    urlFoto2 = urlFoto2.replaceAll('%2F', '/');
    urlFoto2 = urlFoto2.split('?alt')[0];

    // Validate image size
    const imageRef = admin.storage().bucket("crud-db-e2974.appspot.com").file(urlFoto2);
    const metadata = await imageRef.getMetadata();
    const sizeInBytes = metadata[0].size;

    if (sizeInBytes > 2 * 1024 * 1024) {
        return res.status(200).json({ result: 'verificar imagen' });
    }

    // Validate names
    if (!/^[a-zA-Z]{1,30}$/.test(primerNombre) && primerNombre) {
        return res.status(200).json({ result: 'verificar vacio' });
    }

    if (/^ *$/.test(segundoNombre) && segundoNombre) {
        segundoNombre = "";
    }

    if (/^ *$/.test(apellidos) && apellidos) {
        return res.status(200).json({ result: 'verificar vacio' });
    }

    // Check if the document number already exists
    const docSnapshot = await collection.findOne({ numeroDocumento: numeroDocumento });
    if (docSnapshot) {
        return res.status(200).json({ result: 'verificar repetido' });
    }

    // Create user document
    const userDocument = {
        urlFoto,
        tipoDocumento,
        numeroDocumento,
        primerNombre,
        segundoNombre,
        apellidos,
        fechaNacimiento,
        genero,
        correo,
        celular,
    };

    try {
        await collection.insertOne(userDocument);
        const logDocument = {
            id: numeroDocumento,
            tipo: 'Crear',
            fecha: formatDate(new Date()),
        };
        await logCollection.insertOne(logDocument);
        return res.status(200).json({ result: 'exito' });
    } catch (error) {
        console.error('Error creating user:', error);
        return res.status(500).json({ result: 'error' });
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
