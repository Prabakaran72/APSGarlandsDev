import React, {useState, useEffect} from 'react'



const Options = ({value, setValue}) => {

    // const weight = [
    //     {value: '', name: 'Please Select'},   
    //     {value: 'gram', name: 'Gram'},
    //     {value: 'kilogram', name: 'Kilogram'},        
    // ]
    const colors = [
        {value: '', name: 'Please Select'},   
        {value: 'red', name: 'Red'},
        {value: 'blue', name: 'Blue'},
        {value: 'black', name: 'Black'},
        {value: 'green', name: 'Green'},
        {value: 'yellow', name: 'Yellow'},
    ]
    const size = [
        {value: '', name: 'Please Select'},       
        {value: 'dimension', name: 'Dimensions'},       
    ]

    const [firstOption, setFirstOption] = useState([       
        {value: 'color', name: 'Color'},
        {value: 'size', name: 'Size'},
    ]);

    const [topOption, setTopOption] = useState(colors);   
    const [middleOption, setMiddleOption] = useState(colors);   
    const [middleBottomOption, setMiddleBottomOption] = useState(colors);   
    const [bottomOption, setBottomOption] = useState(colors);       
    const [input, setInput] = useState({
        top: 'color',
        middle: 'color',
        middleBottom: 'color',
        bottom: 'color'
    });   
    const [dependencyInput, setDependencyInput] = useState({
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
              

    const handleChange = (e) => {      
        setInput({...input, [e.target.name]: e.target.value});         
                
        if(e.target.value === 'color')
        {
            setTopOption(colors);
        }
        else if(e.target.value === 'size')
        {
            setTopOption(size);
        }
        else {
            setTopOption(colors);
        }
    }

    const handleChangeMiddle = (e) => {
        setInput({...input, [e.target.name]: e.target.value}); 
      
        if(e.target.value === 'color')
        {
            setMiddleOption(colors);
        }
        else if(e.target.value === 'size')
        {
            setMiddleOption(size);
        }
        else {
            setMiddleOption(colors);
        }
    }

    const handleChangeBottomMiddle = (e) => {
        setInput({...input, [e.target.name]: e.target.value}); 
        
        if(e.target.value === 'color')
        {
            setMiddleBottomOption(colors);
        }
        else if(e.target.value === 'size')
        {
            setMiddleBottomOption(size);
        }
        else {
            setMiddleBottomOption(colors);
        }
    }

    const handleChangeBottom = (e) => {
        setInput({...input, [e.target.name]: e.target.value}); 
       
        if(e.target.value === 'color')
        {
            setBottomOption(colors);
        }
        else if(e.target.value === 'size')
        {
            setBottomOption(size);
        }
        else {
            setBottomOption(colors);
        }
    }


    const handleChangeSelectTop = (e) => {        
        setDependencyInput({...dependencyInput, [e.target.name]: e.target.value});  
        setValue((prev)=>({...prev, [e.target.name]: e.target.value}));  
    }
    const handleChangeSelectMiddle = (e) => {        
        setDependencyInput({...dependencyInput, [e.target.name]: e.target.value});    
        setValue((prev)=>({...prev, [e.target.name]: e.target.value}));  
    }
    const handleChangeSelectMiddleBottom = (e) => {        
        setDependencyInput({...dependencyInput, [e.target.name]: e.target.value}); 
        setValue((prev)=>({...prev, [e.target.name]: e.target.value}));     
    }
    const handleChangeSelectBottom = (e) => {        
        setDependencyInput({...dependencyInput, [e.target.name]: e.target.value});   
        setValue((prev)=>({...prev, [e.target.name]: e.target.value}));   
    }



    const handleValue = (e) => {        
        setDependencyInput({...dependencyInput, [e.target.name]: e.target.value});  
        setValue((prev)=>({...prev, [e.target.name]: e.target.value}));  
    }
        
    
    // console.log('value',value);    
    
  return (
    <>
        <div className='Options'>            
            <div className='container structure'>
                <div className='Top input-align'>
                <h3>Top</h3>
                    <div className='d-flex'>
                        <select id='top' className='form-control' name='top' value={input.top} onChange={(e)=>handleChange(e)}>
                            {firstOption.map((item,i) => (                                    
                                    <option key={i} value={item.value}>{item.name}</option>                                                                                                                                        
                            ))}                                
                        </select>
                        { input.top == 'color' ?                           
                                
                            <select className='form-control' name='top_Input_Color' value={dependencyInput.top_Input_Color}  onChange={(e)=>handleChangeSelectTop(e)}>
                                {topOption.map((item)=>(
                                    <option value={item.value}>{item.name}</option> 
                                ))}                                
                            </select>                           
                          : 
                            <>
                                L: <input type='number' name='top_Input_Height' value={dependencyInput.top_Input_Height} onChange={(e)=>handleValue(e)} className='form-control' />
                                B: <input type='number' name='top_Input_Width' value={dependencyInput.top_Input_Width} onChange={(e)=>handleValue(e)} className='form-control' /> 
                            </>                         
                        }
                    </div>
                </div>

                <div className='Middle input-align'>
                    <h3>Middle</h3>
                    <div className='d-flex'>
                        <select id='top' className='form-control' name='middle' value={input.middle} onChange={(e)=>handleChangeMiddle(e)}>
                            {firstOption.map((item,i) => (
                                <>
                                    <option key={i} value={item.value}>{item.name}</option>                                       
                                </>                            
                            ))}                                
                        </select>
                        { input.middle == 'color' ?  
                            <select className='form-control' name='middle_Input_Color' value={dependencyInput.middle_Input_Color}  onChange={(e)=>handleChangeSelectMiddle(e)}>
                                {middleOption.map((item)=>(
                                    <option value={item.value}>{item.name}</option>                               
                                ))}                                
                            </select>
                            :
                            <>
                                L: <input type='number' name='middle_Input_Height' value={dependencyInput.middle_Input_Height} onChange={(e)=>handleValue(e)} className='form-control' />
                                B: <input type='number' name='middle_Input_Width' value={dependencyInput.middle_Input_Width} onChange={(e)=>handleValue(e)} className='form-control' /> 
                            </>   
                        } 
                    </div>
                </div>

                <div className='Bottom-middle input-align'>
                    <h3>Bottom-middle</h3>
                    <div className='d-flex'>
                        <select id='top' className='form-control' name='middleBottom' value={input.middleBottom} onChange={(e)=>handleChangeBottomMiddle(e)}>
                            {firstOption.map((item,i) => (
                                <>
                                    <option key={i} value={item.value}>{item.name}</option>                                       
                                </>                            
                            ))}                                
                        </select>
                        { input.middleBottom == 'color' ?  
                            <select className='form-control' name='middle_Bottom_Input_Color' value={dependencyInput.middle_Bottom_Input_Color} onChange={(e)=>handleChangeSelectMiddleBottom(e)} >
                                {middleBottomOption.map((item)=>(
                                    <option value={item.value}>{item.name}</option>                               
                                ))}                                
                            </select>
                            :
                            <>
                                L: <input type='number' name='middle_Bottom_Input_Height' value={dependencyInput.middle_Bottom_Input_Height} onChange={(e)=>handleValue(e)} className='form-control' />
                                B: <input type='number' name='middle_Bottom_Input_Width' value={dependencyInput.middle_Bottom_Input_Width} onChange={(e)=>handleValue(e)} className='form-control' /> 
                            </>    
                        }
                    </div>
                </div>

                <div className='Bottom input-align'>
                    <h3>Bottom</h3>
                    <div className='d-flex'>
                        <select id='top' className='form-control' name='bottom' value={input.bottom} onChange={(e)=>handleChangeBottom(e)}>
                            {firstOption.map((item,i) => (                               
                                <option key={i} value={item.value}>{item.name}</option>                                                                                          
                            ))}                                
                        </select>
                        { input.bottom == 'color' ? 
                            <select className='form-control' name='bottom_Input_Color' value={dependencyInput.bottom_Input_Color} onChange={(e)=>handleChangeSelectBottom(e)} >
                                {bottomOption.map((item)=>(
                                    <option value={item.value}>{item.name}</option>                               
                                ))}                                
                            </select>
                           :
                            <>
                                L: <input type='number' name='bottom_Input_Height' value={dependencyInput.bottom_Input_Height} onChange={(e)=>handleValue(e)} className='form-control' />
                                B: <input type='number' name='bottom_Input_Width' value={dependencyInput.bottom_Input_Width} onChange={(e)=>handleValue(e)} className='form-control' /> 
                            </>    
                        }                      
                    </div>
                </div>   
            </div>                         
        </div>
    </>
  )
}

export default Options

