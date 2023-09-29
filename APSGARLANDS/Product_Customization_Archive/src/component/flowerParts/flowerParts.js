import Slick from 'react-slick';
import './flowerParts.css';
import { Card, Grid } from '@mui/material';
import "slick-carousel/slick/slick.css";
import jasmincard from '../../assets/jasmincard.jpeg'
import redrosecard from '../../assets/redrosecard.jpg'
import yellowrosecard from '../../assets/yellowrosecard.png'
import senvanthipoocard from '../../assets/senvanthipoocard.jpg'
import mariglodorangecard from '../../assets/mariglodorangecard.jpg'
import mariglodyellowcard from '../../assets/mariglodyellowcard.jpg'
import vadamallicard from '../../assets/vadamallicard.jpg'
import tulasicard from '../../assets/tulasicard.jpg'
import Arugampulcard from '../../assets/Arugampulcard.jpg'
import pannircard from '../../assets/pannircard.jpg'
import lilycard from '../../assets/lilycard.jpg'
import React, { useState } from 'react';
import "slick-carousel/slick/slick-theme.css";
export default function FlowerParts(props){
  
  const data = [1,2,3,4,5];
  const flowerData = [
    { name: 'Jasmine', image: jasmincard  ,value :'jasmincard'},
    { name: 'Red Rose', image: redrosecard ,value :'redrosecard'},
    { name: 'Yellow Rose', image: yellowrosecard ,value :'yellowrosecard'},
    { name: 'Senvanthi Poo', image: senvanthipoocard ,value :'senvanthipoocard'},
    { name: 'Marigold Orange', image: mariglodorangecard,value :'mariglodorangecard' },
    { name: 'Marigold Yellow', image: mariglodyellowcard ,value :'mariglodyellowcard'},
  ];
  const Middleflower = [
    { name: 'Jasmine', image: jasmincard ,value :'jasmincard'},
    { name: 'Red Rose', image: redrosecard ,value :'redrosecard'},
    { name: 'Arugampul', image: Arugampulcard ,value :'Arugampulcard'},
    { name: 'Senvanthi Poo', image: senvanthipoocard ,value :'senvanthipoocard'},
    { name: 'tulasicard', image: tulasicard ,value :'tulasicard'},
    { name: 'Vadamalli', image: vadamallicard ,value :'vadamallicard'},
  ];
  const bottomKonda = [
    { name: 'Jasmine', image: jasmincard ,value :'jasmincard'},
    { name: 'Red Rose', image: redrosecard ,value :'redrosecard'},
    { name: 'Yellow Rose', image: yellowrosecard ,value :'yellowrosecard'},
    { name: 'Senvanthi Poo', image: senvanthipoocard ,value :'senvanthipoocard'},
    { name: 'Lily ', image: lilycard ,value :'lilycard'},
    { name: 'Pannir Rose', image: pannircard ,value :'pannircard'},
    
    { name: 'Vadamalli', image: vadamallicard ,value :'vadamallicard'},
  ];
   const settings = {
    // dots: true,
     infinite: true,
    speed: 1000,
    slidesToShow: 3,
    slidesToScroll: 1,  
    prevArrow: <div ><p>{"<-"}</p></div>,   
    nextArrow: <div ><p>{"->"}</p></div>
  };

  const handleClick=(e)=>{
    console.log(e.target.value);
  }
  const handleImageClick = (flowerName,partName) => {
    console.log('partName',partName);
    props.setSelectedFlower(flowerName);
    props.setPartFlower(partName);
    // Do something when an image is clicked, e.g., open a modal or navigate to a new page
    console.log(`Clicked on ${flowerName}`);
  };
  
    return (
      <>
        <div className="container">
          <div className="option_garland_chose">
            <div className="top_garland_option">
              <div className="top_part_option">
                <h3>Top</h3>
                <Slick {...settings}>
                {flowerData.map((item, index) => (
                  <Grid container key={index}>
                    <Grid item xs={12} sm={6} md={4} lg={3} rowSpacing={1}>
                      <Card className="top_part_cards">
                      <a href="#" onClick={() => handleImageClick(item.value,'toprow')}>
                <img
                  src={item.image}
                  alt={item.name}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                  }}
                />
              </a>
                      </Card>
                      <p>{item.name}</p>
                    </Grid>
                  </Grid>
                ))}
                </Slick>
                <h3>Middle</h3>
                <Slick {...settings}>
                {Middleflower.map((item, index) => (
                  <Grid container key={index}>
                    <Grid item xs={12} sm={6} md={4} lg={3} rowSpacing={1}>
                      <Card className="top_part_cards">
                      <a href="#" onClick={() => handleImageClick(item.value,'middleball')}>
                <img
                  src={item.image}
                  alt={item.name}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                  }}
                />
              </a>
                      </Card>
                      <p>{item.name}</p>
                    </Grid>
                  </Grid>
                ))}
                </Slick>
                <h3>Bottom-middle</h3>
                <Slick {...settings}>
                {flowerData.map((item, index) => (
                  <Grid container key={index}>
                    <Grid item xs={12} sm={6} md={4} lg={3} rowSpacing={1}>
                      <Card className="top_part_cards">
                      <a href="#" onClick={() => handleImageClick(item.value,'middlerow')}>
                <img
                  src={item.image}
                  alt={item.name}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                  }}
                />
              </a>
                      </Card>
                      <p>{item.name}</p>
                    </Grid>
                  </Grid>
                ))}
                </Slick>
                <h3>Bottom</h3>
                <Slick {...settings}>
                {bottomKonda.map((item, index) => (
                  <Grid container key={index}>
                    <Grid item xs={12} sm={6} md={4} lg={3} rowSpacing={1}>
                      <Card className="top_part_cards">
                      <a href="#" onClick={() => handleImageClick(item.value,'endball')}>
                <img
                  src={item.image}
                  alt={item.name}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                  }}
                />
              </a>
                      </Card>
                      <p>{item.name}</p>
                    </Grid>
                  </Grid>
                ))}
                </Slick>
              </div>
            </div>
          </div>
        </div>
      </>
    );
}