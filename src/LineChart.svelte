<script>
	
	import { scaleTime, scaleLinear } from 'd3-scale';
	import { extent, max } from 'd3-array';
	import { line } from 'd3-shape';
	import { timeParse } from 'd3-time-format';

	import Axis from './Axis.svelte';

	export let data;

	function fToC(fahrenheit) {
   		const fTemp = fahrenheit;
   		const fToCel = (fTemp - 32) * 5 / 9;
   		return fToCel;
 	}	

	const height = 400;
	const margin = 40;	

	const dateParser = timeParse("%Y-%m-%d")

	let width;

	console.log(width);

	$: xScale = scaleTime()
		.domain(extent(data, d => new Date(dateParser(d.date))))
		.range([margin, width - margin]);

	$: yScale = scaleLinear()
		.domain([-15, max(data, d => fToC(+d.temperatureMax))])
		.range([height - margin, margin]);

	$: lineGenerator = line()
		.x(d => xScale(new Date(d.date)))
		.y(d => yScale(fToC(+d.temperatureMax)));		

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



<div class='line-chart' bind:clientWidth={width}>
	{#if width}
		<svg width={width} height={height}>
			<rect 
			x={margin}
			y={yScale(fToC(32))}
			width={width - margin - margin}
			height={height - yScale(fToC(32)) - margin}
			style="fill:#e0f3f3"
			/>
			<Axis {width} {height} {margin} scale={xScale} position='bottom' />
			<Axis {width} {height} {margin} scale={yScale} position='left' />
			<path
				d={lineGenerator(data)}
				stroke='rebeccapurple'
				stroke-width={2}
				stroke-linecap='round'
				fill='none'
				in:reveal={{ duration: 1500 }}
			/>
			
		</svg>
	{/if}
</div>
