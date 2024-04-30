const express = require('express');
const admin = require('firebase-admin');
const { MongoClient } = require('mongodb');
require('dotenv').config();

const serviceAccount = require('./cruddbkey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const app = express();
const PORT = 3200;

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

app.post('/update', async (req, res) => {
    let {
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

    const connection = await getConnection();
    const collection = connection.db('MainDB').collection('usuarios');
    const logCollection = connection.db('MainDB').collection('log');

    function formatDate(date) { 
    const day = date.getDate().toString().padStart(2, '0'); 
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear(); 
    return `${day}-${month}-${year}`; 
    }

    if (/^ *$/.test(fechaNacimiento) && fechaNacimiento) {
        fechaNacimiento="";
    }

    if (/^ *$/.test(correo) && correo) {
        correo="";
    }

    if (/^ *$/.test(celular) && celular) {
        celular="";
    }

    if (/^ *$/.test(segundoNombre) && segundoNombre) {
        segundoNombre="";
    }

    if (urlFoto){
    var urlFoto2 = urlFoto.replace('https://firebasestorage.googleapis.com/v0/b/crud-db-e2974.appspot.com/o/', '');  
    urlFoto2 = urlFoto2.replace('%2F', '/');
    urlFoto2 = urlFoto2.replace('%2F', '/');
    urlFoto2 = urlFoto2.split('?alt')[0];
    const imageRef = admin.storage().bucket("crud-db-e2974.appspot.com").file(urlFoto2);

    // Obtener los metadatos de la imagen
    const metadata = await imageRef.getMetadata();

    // Obtener el tamaño de la imagen en bytes
    const sizeInBytes = metadata[0].size;
    
    if (sizeInBytes > 2 * 1024 * 1024) {
        return res.status(400).json({ result: 'verificar imagen'});
    } 
    }

    if (!/^[a-zA-Z]{1,30}$/.test(primerNombre) && primerNombre) {
        return res.status(400).json({ result: 'verificar vacio'});
    }

    if (/^ *$/.test(apellidos) && apellidos) {
        return res.status(400).json({ result: 'verificar vacio'});
    }

    // Verificar si el ID ya existe en MongoDB
    const docSnapshot = await collection.findOne({ numeroDocumento: numeroDocumento });
    if (!docSnapshot) {
      return res.status(400).json({ result: 'verificar inexistente'});
    }


    // Crear el objeto con los campos que no son vacíos
    const updateFields = {};
    if (urlFoto && docSnapshot.urlFoto !== urlFoto) updateFields.urlFoto = urlFoto;
    if (tipoDocumento && docSnapshot.tipoDocumento !== tipoDocumento) updateFields.tipoDocumento = tipoDocumento;
    if (primerNombre && docSnapshot.primerNombre !== primerNombre) updateFields.primerNombre = primerNombre;
    if (segundoNombre && docSnapshot.segundoNombre !== segundoNombre) updateFields.segundoNombre = segundoNombre;
    if (apellidos && docSnapshot.apellidos !== apellidos) updateFields.apellidos = apellidos;
    if (fechaNacimiento && docSnapshot.fechaNacimiento !== fechaNacimiento) updateFields.fechaNacimiento = fechaNacimiento;
    if (genero && docSnapshot.genero !== genero) updateFields.genero = genero;
    if (correo && docSnapshot.correo !== correo) updateFields.correo = correo;
    if (celular && docSnapshot.celular !== celular) updateFields.celular = celular;

    // Verificar si no hay cambios para actualizar
    if (Object.keys(updateFields).length === 0) {
        return res.status(400).json({ result: 'verificar incompleto'});
    }

    try{
    await collection.updateOne(
            { numeroDocumento: numeroDocumento },
            { $set: updateFields }
        );
        // Crear el registro en el log
        const logDocument = {
            id: numeroDocumento,
            tipo: 'Actualizar',
            fecha: formatDate(new Date())
        };
        await logCollection.insertOne(logDocument);
        return res.status(200).json({ result: 'exito' });
    } catch(error){
        return res.status(500).json({ result: 'error' });
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
