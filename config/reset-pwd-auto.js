const path = require('path');
const bcrypt = require('bcryptjs');
const mongoose = require('mongoose');
require('module-alias')({ base: path.resolve(__dirname, '..', 'api') });
const { User } = require('@librechat/data-schemas').createModels(mongoose);
const connect = require('./connect');

async function doReset() {
  try {
    console.log('Conectando ao banco de dados...');
    await connect();
    const email = 'Nekomayakashi@gmail.com';
    const newPassword = 'a12b3cd4';
    
    console.log(`Buscando usuário: ${email}`);
    const user = await User.findOne({ email });
    if (!user) {
      console.error('Usuário não encontrado!');
      process.exit(1);
    }
    
    console.log('Gerando hash da nova senha...');
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    
    console.log('Atualizando senha no banco de dados...');
    await User.updateOne({ email }, { password: hashedPassword, passwordVersion: Date.now() });
    console.log('✅ Password reset successfully!');
    process.exit(0);
  } catch (err) {
    console.error('Erro ao resetar senha:', err);
    process.exit(1);
  }
}

doReset();
