import { Grid } from '@mui/material';
import React, { useState } from 'react';
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import FlowerCard from './component/flowerCard/flowerCard';
import FlowerParts from './component/flowerParts/flowerParts';
// import HeaderPart  from './component/headerPart/headerPart';

function App() {
  const [selectedFlower, setSelectedFlower] = useState('');
  const [partFlower, setPartFlower] = useState('');
  return (
    <div className="App">
      {/* <HeaderPart  /> */}
      <div className="container">
      
        <div className="main">
          <Grid container>             
            <Grid item xs={4}>
                <FlowerParts setSelectedFlower={setSelectedFlower}
                setPartFlower={setPartFlower}
                />
            </Grid>
            <Grid item xs={8}>
              <div className='flower_main'>
                <FlowerCard  selectedFlower={selectedFlower}  
                partFlower={partFlower}/>
              </div>
            </Grid>
          </Grid>
        </div>
      </div>
    </div>
  );
}

export default App;
