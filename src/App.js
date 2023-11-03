import { Grid } from '@mui/material';
import React, { useState } from 'react';
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import FlowerCard from './component/flowerCard/flowerCard';
import FlowerParts from './component/flowerParts/flowerParts';
import Options from './component/options/options';
// import HeaderPart  from './component/headerPart/headerPart';

function App() {
  const [selectedFlower, setSelectedFlower] = useState('');
  const [partFlower, setPartFlower] = useState('');
  const [human, setHuman] = useState(false);

  const [value, setValue] = useState({   
        top_Input_Color: '',
        top_Input_Height: '',
        top_Input_Width: '',
        middle_Input_Color: '',
        middle_Input_Height: '',
        middle_Input_Width: '',
        middle_Bottom_Input_Color: '',
        middle_Bottom_Input_Height: '',
        middle_Bottom_Input_Width: '',
        bottom_Input_Color: '',
        bottom_Input_Height: '',
        bottom_Input_Width: '',  
  });
  
  const clickHuman = () => {
    setHuman(!human);
  }

  console.log('value',value);  

  return (
    <div className="App">      
      {/* <HeaderPart  /> */}
      <div className="container-fluid">      
        <div className="main">
          <div className='container-fluid'>        
            <div className='row'>
              <div className='col-lg-4'>            
                  <FlowerParts setSelectedFlower={setSelectedFlower}
                  setPartFlower={setPartFlower} human={human}
                  />                 
              </div>
                            
              <div className='col-lg-4'>
                <div className='flower_main'>
                  <div className='flower_main_flower'></div>
                  {/* <div class="human_btn">
                      <button onClick={clickHuman} className='btn btn-danger'>H</button>
                  </div> */}
                  <FlowerCard  selectedFlower={selectedFlower} value={value}  
                  partFlower={partFlower}/>
                </div>
              </div>

              <div className='col-lg-4'>
                  <Options value={value} setValue={setValue} setSelectedFlower={setSelectedFlower}
                  setPartFlower={setPartFlower}
                  />                 
              </div>
            </div>     
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
