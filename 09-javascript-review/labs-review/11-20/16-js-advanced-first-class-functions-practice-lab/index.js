// Code your solution in this file!

const logDriverNames = (array)=>{
  array.forEach(obj => console.log(obj.name));
}

const logDriversByHometown = (array, town)=>{
  array.forEach((obj)=>{
    if(obj.hometown === town) console.log(obj.name);
  });
}

const driversByRevenue = (array)=>{
  return array.slice(0).sort((a,b)=>{ return a.revenue - b.revenue });
}

const driversByName = (array)=>{
  return array.slice(0).sort((a,b)=>{ return a.name.localeCompare(b.name) });
}

const totalRevenue = (array)=>{
  return array.reduce((total, obj)=>{ return total += obj.revenue }, 0);
}

const averageRevenue = (array)=>{
  return totalRevenue(array)/array.length;
}




