<script>
	
	import { scaleTime, scaleLinear } from 'd3-scale';
	import { extent, max } from 'd3-array';
	import { line } from 'd3-shape';	

	import Axis from './Axis.svelte';

	export let data;	

	const height = 400;
	const margin = 40;		

	const width = 800;	

	$: xScale = scaleTime()
		.domain(extent(data, d => new Date((d.Date))))
		.range([margin, width - margin]);

	$: yScale = scaleLinear()
		.domain([0, max(data, d => +d.daily_sum_ill)])
		.range([height - margin, margin]);

	$: lineGenerator_ill = line()
		.x(d => xScale(new Date(d.Date)))
		.y(d => yScale(+d.daily_sum_ill));		

	$: lineGenerator_dead = line()
		.x(d => xScale(new Date(d.Date)))
		.y(d => yScale(+d.daily_sum_dead));	

	$: lineGenerator_recovered = line()
		.x(d => xScale(new Date(d.Date)))
		.y(d => yScale(+d.daily_sum_recovered));		

	const reveal = (node, { duration }) => {
		if (!xScale || !yScale) return;
		const length = node.getTotalLength();
		node.style.strokeDasharray = length;
		return {
			duration,
			css: (t, u) => `stroke-dashoffset: ${u * length}`
		};
	}
</script>



<div class='line-chart'>
	
		<svg width={width} height={height}>
			
			<Axis {width} {height} {margin} scale={xScale} position='bottom' />
			<Axis {width} {height} {margin} scale={yScale} position='left' />
			
			<path
				d={lineGenerator_dead(data)}
				stroke='#e56b6f'
				stroke-width={2}
				stroke-linecap='round'
				fill='none'
				in:reveal={{ duration: 8000 }}
			/>

			<path
				d={lineGenerator_recovered(data)}
				stroke='#02c39a'
				stroke-width={1.8}
				stroke-linecap='round'
				fill='none'
				in:reveal={{ duration: 8000 }}
			/>

			<path
				d={lineGenerator_ill(data)}
				stroke='#6930c3'
				stroke-width={2}
				stroke-linecap='round'
				fill='none'
				in:reveal={{ duration: 8000 }}
			/>
			
		</svg>
	
</div>
