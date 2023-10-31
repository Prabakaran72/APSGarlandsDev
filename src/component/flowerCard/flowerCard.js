import 'bootstrap/dist/css/bootstrap.min.css';
import shoulder from '../../assets/shoulder.png';
import mid from '../../assets/mid.png';

import topp from '../../assets/topp.jpg';
import rose from '../../assets/rerose.jpg';
import jasmin from '../../assets/jasmin.jpg';
import yellowrose from '../../assets/yellowrose.jpg';
import mariglodor from '../../assets/mariglodor.jpg';
import arugammid from '../../assets/arugammid.jpg';
import tulasi from '../../assets/tulasi.jpg';
import vadamali from '../../assets/vadamali.jpg';


import jasminkonda from '../../assets/jasminkonda.jpg';
import konda from '../../assets/konda.png';
import yellowkonda from '../../assets/yellowkonda.jpg';
import sevanthikonda from '../../assets/sevanthikonda.jpg';
import illikonda from '../../assets/illikonda.jpg';
import panirkonda from '../../assets/panirkonda.jpg';
import vadamalikonda from '../../assets/vadamalikonda.jpg';

import './flowerCard.css';
import { Grid } from '@mui/material';
import React, { useState,useEffect  } from 'react';
export default function FlowerCard(props){
  const [topSide, setTopSide] = useState(topp);
  const [middleBall, setMiddleBall] = useState(mid);
  const [middleRow, setMiddlRow] = useState(topp);
  const [endBall, setEndRow] = useState(konda);


  // Styles //
  const top_garland_afterStyle = {
    content: '',
    position: 'absolute',
    width: '100%',
    height: '100%',
    background: props.value.top_Input_Color,
    borderRadius: '9px',
    mixBlendMode: 'hue',
    zIndex: 999999999,
    top: 0,
  }
  const top_garland_height = {
    height: `${props.value.top_Input_Height}px`,        
  }
  const top_garland_width = {
    width: `${props.value.top_Input_Width}px`,        
  }


  const middle_garland_afterStyle = {
    content: '',
    position: 'absolute',    
    width: '100%',
    height: '100%',
    background: props.value.middle_Input_Color,
    borderRadius: '30px',  
    mixBlendMode: 'hue',   
    zIndex: 999999999,     
    transform: 'scale(1.15)',            
  }
  const middle_garland = {
    height: `${props.value.middle_Input_Height}px`,   
    width: `${props.value.middle_Input_Width}px`,   
  }
  
  const middle_bottom_1_garland_afterStyle = {  
    content: '',
    position: 'absolute',
    width: '100%',
    height: '100%',
    background: props.value.middle_Bottom_Input_Color,
    borderRadius: '10px 5px 0px 43px',
    mixBlendMode: 'hue',
    top: 0,
}
  const middle_bottom_2_garland_afterStyle = {  
    content: '',
    position: 'absolute',
    width: '100%',
    height: '100%',
    background: props.value.middle_Bottom_Input_Color,
    borderRadius: '10px 10px 43px 0',
    mixBlendMode: 'hue',
    top: 0,
  }  
  

  useEffect(() => {
    
    // Your code for the effect goes here
    console.log('partFlower',props.partFlower);
    if(props.partFlower=='toprow'){
    if(props.selectedFlower==='jasmincard'){
      setTopSide(jasmin)
      
      
    }else if(props.selectedFlower==='redrosecard'){

      setTopSide(rose);
    }else if(props.selectedFlower=='yellowrosecard'){


      setTopSide(yellowrose);
       
    }
    else if(props.selectedFlower=='senvanthipoocard'){


      setTopSide(topp);
       
    }
    else if(props.selectedFlower=='mariglodorangecard'){


      setTopSide(mariglodor);
       
    }
    else if(props.selectedFlower=='mariglodyellowcard'){


      setTopSide(topp);
       
    }
    else{
      setTopSide(topp);
    }
    
  }
  if(props.partFlower=='middleball'){
    if(props.selectedFlower==='jasmincard'){
      setMiddleBall(jasmin)
      
      
    }else if(props.selectedFlower==='redrosecard'){

      setMiddleBall(rose);
    }else if(props.selectedFlower=='Arugampulcard'){


      setMiddleBall(arugammid);
       
    }
    else if(props.selectedFlower=='senvanthipoocard'){


      setMiddleBall(topp);
       
    }
    else if(props.selectedFlower=='tulasicard'){


      setMiddleBall(tulasi);
       
    }
    else if(props.selectedFlower=='vadamallicard'){


      setMiddleBall(vadamali);
       
    }
    else{
      setMiddleBall(mid);
    }
    

  }
  if(props.partFlower=='middlerow'){

    if(props.selectedFlower==='jasmincard'){
      setMiddlRow(jasmin)
      
      
    }else if(props.selectedFlower==='redrosecard'){

      setMiddlRow(rose);
    }else if(props.selectedFlower=='yellowrosecard'){


      setMiddlRow(yellowrose);
       
    }
    else if(props.selectedFlower=='senvanthipoocard'){


      setMiddlRow(topp);
       
    }
    else if(props.selectedFlower=='mariglodorangecard'){


      setMiddlRow(mariglodor);
       
    }
    else if(props.selectedFlower=='mariglodyellowcard'){


      setMiddlRow(topp);
       
    }
    else{
      setMiddlRow(topp);
    }
    


  }
   if(props.partFlower=='endball'){
    

    if(props.selectedFlower==='jasmincard'){
      setEndRow(jasminkonda)
      
      
    }else if(props.selectedFlower==='redrosecard'){

      setEndRow(konda);
    }else if(props.selectedFlower=='yellowrosecard'){


      setEndRow(yellowkonda);
       
    }
    else if(props.selectedFlower=='senvanthipoocard'){


      setEndRow(sevanthikonda);
       
    }
    else if(props.selectedFlower=='lilycard'){


      setEndRow(illikonda);
       
    }
    else if(props.selectedFlower=='pannircard'){


      setEndRow(panirkonda);
       
    }
    else if(props.selectedFlower=='vadamallicard'){


      setEndRow(vadamalikonda);
       
    }
    else{
      setEndRow(konda);
    }
    



   }
    // Optionally, you can return a cleanup function
    // return () => {
    //   // Cleanup code (runs before the component unmounts or before the effect runs again)
    //   console.log('Cleanup');
    // };
  }, [props.selectedFlower,props.partFlower]); // The empty array as the second argument means the effect runs only on mount and unmount



    return (
      <>
        <div className="container">
          <div className="flower_content_area">
            <div className="container">
              <div className="root_full_contain">
                <div className="root_contain">
                  <Grid container className='drag' draggable>
                    {/* <Grid item xs={12}>
                      <div className="base_of_garland">
                        <div className="base_pic_garland"></div>
                      </div>
                    </Grid> */}
                    <Grid item xs={6}>
                      <div className="mid_of_garland">
                        <div className="topbase_pic1_garland">
                            <div style={middle_garland_afterStyle}></div>
                            <img style={middle_garland} src={middleBall} alt='shoulder_flower' className='top-flower'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="mid_of_garland">
                        <div className="topbase_pic2_garland">
                          <div style={middle_garland_afterStyle}></div>
                          <img style={middle_garland} src={middleBall} alt='shoulder_flower' className='top-flower'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="top_of_garland" style={top_garland_height}>
                        <div className='top_pic1_garland'>
                            <div style={top_garland_afterStyle}></div>
                            <img style={top_garland_width} src={topSide} alt='top_garland' className='top-garland'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="top_of_garland" style={top_garland_height}>
                        <div className="top_pic2_garland">
                          <div style={top_garland_afterStyle}></div>
                          <img style={top_garland_width} src={topSide} alt='top_garland' className='top-garland'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="mid_of_garland">
                        <div className="mid_pic1_garland">
                          <div style={middle_garland_afterStyle}></div>
                          <img style={middle_garland} src={middleBall} className='center-mid-flower'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="mid_of_garland">
                        <div className="mid_pic2_garland">
                          <div style={middle_garland_afterStyle}></div>
                          <img style={middle_garland} src={middleBall} className='center-mid-flower'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="botmid_of_garland">
                        <div className="botmid_pic1_garland">
                          <div style={middle_bottom_1_garland_afterStyle}></div>
                          <img src={middleRow} alt='top_garland' className='image1_fitting_bottom bottom-garaland1'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={6}>
                      <div className="botmid_of_garland">
                        <div className="botmid_pic2_garland">
                          <div style={middle_bottom_2_garland_afterStyle}></div>
                          <img src={middleRow} alt='top_garland' className='image2_fitting_bottom bottom-garaland2'/>
                        </div>
                      </div>
                    </Grid>
                    <Grid item xs={12}>
                      <div className="under_of_garland">
                        <div className='under_pic_garland'>
                        <img src={endBall} alt='top_garland' className='image_fitting'/>
                        </div>
                      </div>
                    </Grid>
                  </Grid>
                </div>
              </div>
            </div>
          </div>
        </div>
      </>
    );
}